#!/bin/bash

# Prompt user for file name
read -p "Enter the path to the text file: " FILE

# Check if file exists
if [ ! -f "$FILE" ]; then
    echo "Error: File does not exist."
    exit 1
fi

# Count lines, words, characters
LINES=$(wc -l < "$FILE")
WORDS=$(wc -w < "$FILE")
CHARS=$(wc -m < "$FILE")

# Find the longest word
LONGEST_WORD=$(tr -cs 'A-Za-z' '\n' < "$FILE" | awk '{ if (length > max) { max = length; word = $0 } } END { print word }')

# Output results
echo "Analysis of '$FILE':"
echo "-----------------------------"
echo "Lines     : $LINES"
echo "Words     : $WORDS"
echo "Characters: $CHARS"
echo "Longest word: $LONGEST_WORD"

