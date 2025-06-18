#!/bin/zsh
:<<MAN
This script is used to retrieve and write .txt data files, 
it needs a variable names $CONFIG_FILE, set to default as 
the settings.txt file in the global dir. This variable could be 
changed to point any other file once sourced this script.
MAN

CONFIG_FILE="$(dirname "$0")/../global/data/settings.txt"

# Function to get value by key
get_value() {
    local key=$1
    grep "^${key}=" "$CONFIG_FILE" | cut -d'=' -f2-
}

# Function to set a value and key
set_value() {
    local key=$1
    local value=$2
    
    # Remove existing key if it exists
    grep -v "^${key}=" "$CONFIG_FILE" > "${CONFIG_FILE}.tmp" 2>/dev/null || touch "${CONFIG_FILE}.tmp"
    
    # Add new key-value pair
    echo "${key}=${value}" >> "${CONFIG_FILE}.tmp"
    
    # Replace original file
    mv "${CONFIG_FILE}.tmp" "$CONFIG_FILE"
}
