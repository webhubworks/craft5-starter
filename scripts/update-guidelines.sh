#!/bin/bash
# Sync the webhub Craft CMS AI guidelines into .ai/guidelines/.
# Always exits 0 so it never breaks a composer install — e.g. when offline,
# the curl just fails and we skip silently.

GREEN='\033[1;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

mkdir -p .ai/guidelines

if curl -fsL --connect-timeout 5 --max-time 30 \
    -o .ai/guidelines/webhub-craft-cms.md \
    https://raw.githubusercontent.com/webhubworks/ai/main/guidelines/webhub-craft-cms.md; then
    echo -e "${GREEN}✔ Updated .ai/guidelines/webhub-craft-cms.md${NC}"
else
    echo -e "${YELLOW}⚠ Could not fetch webhub Craft CMS guidelines (offline?). Skipping.${NC}"
fi

exit 0
