#!/bin/bash

# ---------------------------
# Configuration
# ---------------------------
LOG_DIR="/var/logs/checkins"
BACKUP_DIR="/backup/logs"
LOGFILE="/var/log/log_backup.log"
RETENTION_DAYS=7

TIMESTAMP=$(date "+%Y-%m-%d_%H-%M-%S")

# Ensure backup directory exists
mkdir -p "$BACKUP_DIR"

# Find logs older than 7 days
OLD_LOGS=$(find "$LOG_DIR" -type f -mtime +$RETENTION_DAYS)

for FILE in $OLD_LOGS; do
    BASENAME=$(basename "$FILE")
    ARCHIVE_NAME="$BACKUP_DIR/${BASENAME}_$TIMESTAMP.tar.gz"
    
    # Backup
    tar -czf "$ARCHIVE_NAME" -C "$LOG_DIR" "$BASENAME"
    
    # Check if backup successful, then delete original log
    if [ $? -eq 0 ]; then
        rm -f "$FILE"
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] Backup and deleted: $FILE -> $ARCHIVE_NAME" >> "$LOGFILE"
    else
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] ERROR backing up: $FILE" >> "$LOGFILE"
    fi
done
