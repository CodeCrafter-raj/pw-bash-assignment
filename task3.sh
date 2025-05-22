#!/bin/bash

# Input and output files
USER_FILE="user_list.txt"
CREDENTIALS_FILE="credentials.txt"

# Clear the credentials file if it exists
> "$CREDENTIALS_FILE"

# Function to generate random passwords
generate_password() {
    # Generate a 12-character random password
    tr -dc 'A-Za-z0-9@#$%&*' </dev/urandom | head -c 12
}

# Read usernames from file and process
while IFS= read -r username; do
    if [[ -n "$username" ]]; then
        password=$(generate_password)
        echo "Simulating user creation: $username"
        echo "$username:$password" >> "$CREDENTIALS_FILE"
    fi
done < "$USER_FILE"

echo "Credentials saved to $CREDENTIALS_FILE"

