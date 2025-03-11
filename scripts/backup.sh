#!/bin/bash

GREEN='\033[1;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

set -a && source .env && set +a

if [ "$BACKUP_ENABLED" != "true" ]; then
  echo -e "${YELLOW}Backup is not enabled. Check your .env file configuration.${NC}"
  exit 1
fi

if [ -z "${BACKUP_PASSWORD}" ]; then
  echo -e "${YELLOW}Backups are currently not encrypted by password. Consider setting BACKUP_PASSWORD in .env${NC}"
fi

source "$(dirname $0)/craft-simple-backup/backup.sh"
