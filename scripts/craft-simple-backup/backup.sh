#!/bin/bash

# Constants
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_DIR="${BACKUP_STORAGE_LOCATION}/${TIMESTAMP}"
DB_BACKUP_PATH="/tmp/db_backup.sql"
DB_ZIP_FILE="backup_database_${TIMESTAMP}.zip"
UPLOADS_ZIP_FILE="backup_contents_${TIMESTAMP}.zip"

# Ensure backup storage exists
if [[ ! -d "$BACKUP_STORAGE_LOCATION" ]]; then
    printf "Error: Backup storage directory %s does not exist\n" "$BACKUP_STORAGE_LOCATION" >&2
    exit 1
fi

# Create timestamped backup directory
mkdir -p "$BACKUP_DIR"

# Function to create a database backup
backup_database() {
    if ! $BACKUP_CRAFT_CLI db/backup "$DB_BACKUP_PATH"; then
        printf "Database backup failed\n" >&2
        return 1
    fi

    if ! zip -P "$BACKUP_PASSWORD" -j "${BACKUP_DIR}/${DB_ZIP_FILE}" "$DB_BACKUP_PATH"; then
        printf "Failed to compress database backup\n" >&2
        return 1
    fi

    rm -f "$DB_BACKUP_PATH"
}

# Function to backup uploaded files
backup_uploads() {
    if ! zip -r "${BACKUP_DIR}/${UPLOADS_ZIP_FILE}" "$BACKUP_UPLOADS_DIR/"; then
        printf "Failed to compress uploaded files\n" >&2
        return 1
    fi
}

# Function to clean up old backups
cleanup_old_backups() {
    if ! find "$BACKUP_STORAGE_LOCATION" -mindepth 1 -maxdepth 1 -type d -mtime +"$BACKUP_RETENTION_DAYS" -exec rm -rf {} +; then
        printf "Failed to clean up old backups\n" >&2
        return 1
    fi
}

# Main function
main() {
    if ! backup_database; then
        printf "Database backup process encountered an error\n" >&2
        return 1
    fi

    if ! backup_uploads; then
        printf "Uploads backup process encountered an error\n" >&2
        return 1
    fi

    if ! cleanup_old_backups; then
        printf "Cleanup process encountered an error\n" >&2
        return 1
    fi

    printf "Backup completed successfully and stored in %s\n" "$BACKUP_DIR"
}

main
