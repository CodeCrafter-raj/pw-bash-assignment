#!/bin/bash

PACKAGE_FILE="packages.txt"
LOG_FILE="install_log.txt"

# Detect package manager
if command -v apt >/dev/null 2>&1; then
    PACKAGE_MANAGER="apt"
    INSTALL_CMD="sudo apt install -y"
elif command -v yum >/dev/null 2>&1; then
    PACKAGE_MANAGER="yum"
    INSTALL_CMD="sudo yum install -y"
elif command -v dnf >/dev/null 2>&1; then
    PACKAGE_MANAGER="dnf"
    INSTALL_CMD="sudo dnf install -y"
elif command -v pacman >/dev/null 2>&1; then
    PACKAGE_MANAGER="pacman"
    INSTALL_CMD="sudo pacman -S --noconfirm"
else
    echo "No supported package manager found." | tee -a "$LOG_FILE"
    exit 1
fi

echo "Using package manager: $PACKAGE_MANAGER" | tee -a "$LOG_FILE"

# Ensure the package file exists
if [ ! -f "$PACKAGE_FILE" ]; then
    echo "Error: $PACKAGE_FILE not found." | tee -a "$LOG_FILE"
    exit 1
fi

# Read and install packages
while IFS= read -r package; do
    if [[ -n "$package" ]]; then
        echo "Installing $package..." | tee -a "$LOG_FILE"
        if $INSTALL_CMD "$package" >>"$LOG_FILE" 2>&1; then
            echo "$package: SUCCESS" | tee -a "$LOG_FILE"
        else
            echo "$package: FAILED" | tee -a "$LOG_FILE"
        fi
        echo "-----------------------------" >> "$LOG_FILE"
    fi
done < "$PACKAGE_FILE"

echo "Installation process completed. Log saved to $LOG_FILE."

