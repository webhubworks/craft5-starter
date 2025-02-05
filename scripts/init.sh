#!/bin/bash

GREEN='\033[1;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

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

echo -e "${GREEN}✔ Updated project name in composer.json, package.json, and .ddev/config.yaml.${NC}"
