#!/bin/bash
# Usage: ./keygen.sh <keyName> <email>

# Check if the required parameters are provided
if [ $# -ne 2 ]; then
    echo "Usage: $0 <keyName> <email>"
    exit 1
fi

keyName=$1
email=$2

# Generate SSH key with the correct syntax
# The -t flag specifies the type of key (like rsa, ed25519)
# Using "id_$keyName" as the filename
ssh-keygen -t rsa -f ~/.ssh/id_$keyName -C "$email"

# Start the SSH agent
eval "$(ssh-agent -s)"

# Add the private key to the SSH agent
ssh-add ~/.ssh/id_$keyName

echo "SSH key generated successfully!"
echo "Your public key is located at: ~/.ssh/id_$keyName.pub"
