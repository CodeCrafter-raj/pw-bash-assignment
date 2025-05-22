#!/bin/bash

# Define the backup directory path
BACKUP_DIR="C:\Users\RAj\Desktop\backup"

# 1. Create the "backup" directory if it doesn't exist
if [ ! -d "$BACKUP_DIR" ]; then
  mkdir -p "$BACKUP_DIR"
  echo "Created directory: $BACKUP_DIR"
else
  echo "Directory already exists: $BACKUP_DIR"
fi

# Get the current date and time in a friendly format
CURRENT_DATETIME=$(date +"%Y%m%d_%H%M%S")

# 2. Copy all .txt files from the current directory to the "backup" directory
# 3. Append the current date and time to the filenames of the copied files.
for file in *.txt; do
  if [ -f "$file" ]; then # Ensure it's a regular file
    filename=$(basename -- "$file")
    extension="${filename##*.}"
    filename_no_ext="${filename%.*}"
    new_filename="${filename_no_ext}_${CURRENT_DATETIME}.${extension}"
    cp "$file" "$BACKUP_DIR/$new_filename"
    echo "Copied '$file' to '$BACKUP_DIR/$new_filename'"
  fi
done

echo "Backup process completed."
