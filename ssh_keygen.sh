#!/bin/bash

# This script is used to generate an SSH key for 
# Documenter jobs to authenticate with GitHub, as described at 
# https://juliadocs.github.io/Documenter.jl/stable/man/hosting/walkthrough/#SSH-Deploy-Keys-Walkthrough

# 1. Check that one argument was supplied
if [ $# -eq 0 ];
then echo "Error: one argument with the name of the SSH key must be supplied" && exit 1;
elif [ $# -gt 1 ];
then echo "Error: too many arguments. Only the name of the SSH key must be supplied" && exit 1;
fi

echo "Requested generation of '$1' SSH key"

# 2. Check that an existing SSH keys with the same name would not be overwritten

if [ -f "temp/$1_SSH_KEY" ]||[ -f "temp/$1_SSH_KEY.pub" ]||[ -f "temp/$1_SSH_KEY.base64" ]; 
then echo -e "Files related to the $1 KEY were found and will NOT be overwritten. \n\tThey must be deleted before a new key can be generated." && exit 1;
fi

# 3. Clean-up any metadata file possibly left over from an SSH key with the same name
rm -f "temp/$1_SSH_KEY.metadata"

# 4. Generate public and private SSH keys using ssh-keygen
ssh-keygen -N "" -f "temp/$1_SSH_KEY" > "temp/$1_SSH_KEY.metadata"

# 5. Base64 encode the private key using openssl base64
openssl base64 -in "temp/$1_SSH_KEY" -out "temp/$1_SSH_KEY.base64"

# 6. Report the number of generated files
generated=$(ls temp/$1_SSH_KEY*)
echo -e "SSH $1 KEY data saved in 4 files: \n$generated"

echo -e "For adding the generated PUBLIC key to GitHub \n\tGo to https://github.com/[YOUR_USER_NAME]/[YOUR_REPO_NAME]/settings/keys and click 'Add deploy key'."
