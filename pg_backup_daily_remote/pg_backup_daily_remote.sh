#!/usr/bin/env bash

# ------------------------------------------------------------------------------
# Script Name: PostgreSQL Daily Backup + Remote Upload
# Author:      Esteban Herrera Castro
# Email:       stv.herrera@gmail.com
# Date:        10/10/2025
# ------------------------------------------------------------------------------
# Description:
# It automatically backs up all PostgreSQL databases daily, with compression,
# timestamps, and automatic cleanup of old backups. Automatically uploads the
# PostgreSQL backup to a remote server via SSH (using rsync or scp) right after
# creating it.
# ------------------------------------------------------------------------------

# CONFIGURATION
BACKUP_DIR="/var/backups/postgresql"
PG_USER="postgres"
RETENTION_DAYS=7       # Delete local backups older than N days
DATE=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_FILE="$BACKUP_DIR/all_databases_$DATE.sql.gz"
LOG_FILE="$BACKUP_DIR/pg_backup.log"

# REMOTE UPLOAD SETTINGS
REMOTE_USER="backupuser"
REMOTE_HOST="backup.example.com"
REMOTE_DIR="/remote/backups/postgresql"
USE_RSYNC=true   # true = rsync, false = scp
SSH_KEY="/home/$PG_USER/.ssh/id_rsa"  # Adjust if needed

# Ensure the backup directory exists
mkdir -p "$BACKUP_DIR"
chown $PG_USER:$PG_USER "$BACKUP_DIR"

echo "[$(date)] Starting PostgreSQL backup..." >> "$LOG_FILE"

# Perform compressed dump of all databases
sudo -u $PG_USER pg_dumpall | gzip > "$BACKUP_FILE"

if [ $? -eq 0 ]; then
    echo "[$(date)] Backup completed successfully: $BACKUP_FILE" >> "$LOG_FILE"
else
    echo "[$(date)] ERROR: Backup failed!" >> "$LOG_FILE"
    exit 1
fi

# Upload backup to remote server
echo "[$(date)] Uploading backup to remote server..." >> "$LOG_FILE"

if [ "$USE_RSYNC" = true ]; then
    rsync -az -e "ssh -i $SSH_KEY" "$BACKUP_FILE" "$REMOTE_USER@$REMOTE_HOST:$REMOTE_DIR/"
else
    scp -i "$SSH_KEY" "$BACKUP_FILE" "$REMOTE_USER@$REMOTE_HOST:$REMOTE_DIR/"
fi

if [ $? -eq 0 ]; then
    echo "[$(date)] Remote upload successful to $REMOTE_HOST:$REMOTE_DIR" >> "$LOG_FILE"
else
    echo "[$(date)] WARNING: Remote upload failed!" >> "$LOG_FILE"
fi

# Delete local old backups
find "$BACKUP_DIR" -type f -name "all_databases_*.sql.gz" -mtime +$RETENTION_DAYS -exec rm -f {} \;
echo "[$(date)] Cleanup complete. Backups older than $RETENTION_DAYS days removed." >> "$LOG_FILE"
echo "[$(date)] Backup finished." >> "$LOG_FILE"
