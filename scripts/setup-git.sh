#!/bin/bash

# --- Import Common Header --- 

# add header file
CURRENT_FILE_DIR="$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)"

# source header (uses SCRIPT_DIR and loads lib.sh)
if [ -r "$CURRENT_FILE_DIR/dotheader.sh" ]; then
  # shellcheck source=/dev/null
  source "$CURRENT_FILE_DIR/dotheader.sh"
else
  echo "Missing header file: $CURRENT_FILE_DIR/dotheader.sh"
  exit 1
fi

# --- End Import Common Header ---

print_tool_setup_start "Git"

git config --global user.name "Mike de la Fuente"
git config --global user.email "mike.delafuente@gmail.com"
git config --global core.editor "nvim"
git config --global init.defaultBranch main

# Check to see if SSH keys already exist

if [ -f ~/.ssh/id_ed25519 ]; then
    echo "SSH key already exists. Skipping key generation."
else
    echo "Generating new SSH key."

    # Create SSH keys for GitHub using Ed25519
    ssh-keygen -t ed25519 -C "mike.delafuente@gmail.com" -f ~/.ssh/id_ed25519 -N ""
    # Add SSH key to ssh-agent
    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/id_ed25519
    # Display the public key for GitHub
    echo "Your public SSH key is:"
    cat ~/.ssh/id_ed25519.pub
    echo "Copy this key to your GitHub account."
fi

print_tool_setup_complete "Git"