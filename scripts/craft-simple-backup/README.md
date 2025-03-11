# Simple Craft CMS Backup Script
This script is a simple backup script for Craft CMS. It creates a database dump and a zip archive of the single uploaded files directory. Both are stored in a backup directory. The database zip is being encrypted. Old backups are deleted after a certain amount of days.

## Usage

Run it with `./scripts/backup.sh` (not directly through `./scripts/craft-simple-backup/backup.sh`).

### Config

Please remember to set the correct paths and **your own password** in the env file (see `.env.example.production`):

```env
BACKUP_ENABLED=true
BACKUP_CRAFT_CLI="php /home/forge/domain.de/craft" # Path to Craft CLI inluding PHP binary (php|php8.2|...)
BACKUP_UPLOADS_DIR="/home/forge/domain.de/web/uploads" # Path to the single uploaded files directory (WITHOUT TRAILING SLASH)
BACKUP_STORAGE_LOCATION="/home/forge/backups" # Path to top level backup storage location
BACKUP_PASSWORD= # The zip password for the encrypted database backup
BACKUP_RETENTION_DAYS="14" # How many days of backups should be retained
```

## Setting up a Cron job

Set up a cron job to run as often as you like. For example every 6 hours:

```bash
* */6 * * * /path/backup.sh >/dev/null 2>&1
```

Or even better, set up an [Oh Dear](https://ohdear.app/sites) Scheduled Task check to monitor the backup script. You'll be presented with the correct cron job syntax in the Oh Dear dashboard.
