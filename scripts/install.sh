#!/bin/bash

GREEN='\033[1;32m'
YELLOW='\033[1;33m'
RED='\033[1;31m'
NC='\033[0m' # No Color

if ddev craft install/check; then
  exit 0
fi

echo -e "${YELLOW}⚠️ Craft is not installed. Running setup commands...${NC}"

ddev craft setup/app-id
ddev craft setup/security-key

read -p "What is this site called? " SITE_NAME

echo -e "# ${SITE_NAME}\n\n$(cat README.md.default)" > README.md
rm -f README.md.default

if ! command -v op 2>&1 >/dev/null; then
  echo -e "${RED}1Password CLI is not installed, cannot create an account${NC}"
  ddev craft install/craft --site-name="${SITE_NAME}" --site-url="\$PRIMARY_SITE_URL"
else
    echo "Fetching metadata, this can take a few seconds..."

  USER_EMAIL=$(op user get --format=json --me | jq -r '.email')
  SITE_URL=$(ddev describe -j | jq -r '.raw | .primary_url')

  PASSWORD=$(op item create \
    --category=login \
    --title="${SITE_NAME} [CMS]" \
    --vault="Employee" \
    --url "${SITE_URL}/admin/login" \
    --generate-password=20,letters,digits \
    --reveal \
    --format json \
    username="${USER_EMAIL}" | jq -r '.fields[] | select(.id == "password") | .value')

  echo -e "${GREEN}✔ Generated a new 1Password item."

  ddev craft install/craft \
    --interactive=0 \
    --email="${USER_EMAIL}" \
    --username="${USER_EMAIL}" \
    --password="${PASSWORD}" \
    --site-name="${SITE_NAME}" \
    --site-url="\$PRIMARY_SITE_URL" \
    --language="de"
fi

ddev craft plugin/install vite
ddev craft plugin/install ckeditor
ddev craft plugin/install elements-panel
ddev craft plugin/install craft-ray
ddev craft plugin/install seo
ddev craft plugin/install _craft-panoptikum-cell

#echo "Updating Craft & plugins..."

#ddev craft update all --interactive=0 --minor-only

echo "Launching PhpStorm..."

open -a PhpStorm .
