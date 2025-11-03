#!/bin/bash

# Update the system
sudo apt update && sudo apt upgrade -y

# Install essential packages
sudo apt install -y git zsh neovim docker.io openvpn

# Set up Git
git config --global user.name "Your Name"
git config --global user.email "youremail@example.com"
git config --global core.editor "nvim"
git config --global init.defaultBranch main

# Create SSH keys for GitHub
ssh-keygen -t rsa -b 4096 -C "youremail@example.com" -f ~/.ssh/id_rsa -N ""

# Install additional tools
sudo apt install -y curl wget

# Set up Zsh as the default shell
chsh -s $(which zsh)

# Clone and set up LazyVim
git clone https://github.com/yourusername/lazyvim.git ~/.config/nvim

# Set up Docker permissions
sudo usermod -aG docker $USER

# Print completion message
echo "Pop!_OS installation and configuration complete. Please restart your terminal."