#!/bin/bash

# Prompt user for a directory path
read -p "Enter the full path of the directory to back up: " DIR_PATH

# Check if directory exists
if [ ! -d "$DIR_PATH" ]; then
    echo "Error: Directory does not exist."
    exit 1
fi

# Get current date
DATE=$(date +%F)  # format: YYYY-MM-DD

# Create backup filename
BACKUP_NAME="backup_${DATE}.tar.gz"

# Compress the directory
tar -czf "$BACKUP_NAME" -C "$(dirname "$DIR_PATH")" "$(basename "$DIR_PATH")"

# Confirm success
if [ $? -eq 0 ]; then
    echo "Backup successful! Saved as: $BACKUP_NAME"
else
    echo "Backup failed."
fi

