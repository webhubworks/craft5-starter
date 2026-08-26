#!/bin/bash

GREEN='\033[1;32m'
YELLOW='\033[1;33m'
RED='\033[1;31m'
NC='\033[0m' # No Color

# Require auth.json before composer install runs (via ddev post-start hook)
echo -e "${YELLOW}⚠ Paste the auth.json file containing credentials for packages.webhub.de into the project root.${NC}"
read -p "Press enter to continue once auth.json is in place..."

if [ ! -f auth.json ]; then
    echo -e "${RED}auth.json not found in project root. Aborting.${NC}"
    exit 1
fi

# Cleanup starter
[ -f .env ] || cp .env.example.dev .env

rm -f .gitignore
mv .gitignore.default .gitignore

rm -f composer.json
mv composer.json.default composer.json

rm -f composer.lock
rm -f README.md

# Rename project

PROJECT_NAME=$(basename "$PWD")

echo -e "${YELLOW}Enter project name:${NC} (default: $PROJECT_NAME)"
read -r USER_INPUT

PROJECT_NAME=${USER_INPUT:-$PROJECT_NAME}

echo "Setting project name to: $PROJECT_NAME"

# Update composer.json
if [ -f "composer.json" ]; then
    jq --arg name "webhubworks/$PROJECT_NAME" '.name = $name' composer.json > composer.tmp && mv composer.tmp composer.json
fi

# Update package.json
if [ -f "package.json" ]; then
    jq --arg name "$PROJECT_NAME" '.name = $name' package.json > package.tmp && mv package.tmp package.json
fi

# Update .ddev/config.yaml
if [ -f ".ddev/config.yaml" ]; then
    sed -i.bak "s/^name: .*/name: $PROJECT_NAME/" .ddev/config.yaml && rm .ddev/config.yaml.bak
fi

# Set PRIMARY_SITE_URL in .env to the local ddev domain
if [ -f ".env" ]; then
    sed -i.bak "s|^PRIMARY_SITE_URL=.*|PRIMARY_SITE_URL=https://${PROJECT_NAME}.ddev.site|" .env && rm .env.bak
fi

echo -e "${GREEN}✔ Updated project name in composer.json, package.json, and .ddev/config.yaml.${NC}\n"

echo -e "Run ${YELLOW}ddev start${NC} inside the project folder"
