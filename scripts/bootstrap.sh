#!/bin/bash

# create a function that will be used to print green line breaks when called, accpeting a title as an argument

print_line_break() {
  local title="$1"
  echo -e "\e[32m--------------------------------------------------\e[0m"
  if [ -n "$title" ]; then
    echo -e "\e[32m$title\e[0m"
    echo -e "\e[32m--------------------------------------------------\e[0m"
  fi
}

# Update package list and upgrade installed packages
print_line_break "Updating and upgrading packages"
sudo apt update && sudo apt upgrade -y

# Install essential packages
print_line_break "Installing essential packages"
sudo apt install -y git zsh neovim openvpn 

# Install additional tools
print_line_break "Installing additional tools"
sudo apt install -y curl wget

# run the install-docker.sh script to set up Docker using sudo rights
print_line_break "Installing Docker"
sudo bash ./scripts/install-docker.sh

# Set up Git configuration
print_line_break "Setting up Git configuration"
git config --global user.name "Mike de la Fuente"
git config --global user.email "mike.delafuente@gmail.com"
git config --global core.editor "nvim"
git config --global init.defaultBranch main

# Check to see if SSH keys already exist
print_line_break "Setting up SSH keys for GitHub"
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


# Change default shell to zsh
print_line_break "Changing default shell to zsh"
chsh -s $(which zsh)

# Clone and set up Oh My Zsh (optional)
print_line_break "Installing Oh My Zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install Node.js and npm (optional)
print_line_break "Installing Node.js and npm"
curl -fsSL https://deb.nodesource.com/setup_14.x | sudo -E bash -
sudo apt install -y nodejs

# Clean up
print_line_break "Cleaning up"
sudo apt autoremove -y


echo "Bootstrap completed. Please restart your terminal."
