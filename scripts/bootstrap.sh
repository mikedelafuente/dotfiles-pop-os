#!/bin/bash
# -------------------------
# Bootstrap Script for Pop!_OS
# -------------------------

# --------------------------
# Configuration
# --------------------------  
FULL_NAME="Mike de la Fuente"
EMAIL_ADDRESS="mike.delafuente@gmail.com"
DOTNET_CORE_SDK_VERSION="9.0"

# --------------------------
# Start of Script
# --------------------------

echo "Starting bootstrap process... pwd is $(pwd)"
echo "Display server protocol: $XDG_SESSION_TYPE"
echo "Current user: $(whoami)"
echo "Home directory: $HOME"
echo "Shell: $SHELL"
echo "Script directory: $(dirname -- "${BASH_SOURCE[0]}")"
echo "----------------------------------------"

# --------------------------
# Import Common Header 
# --------------------------

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

# --------------------------
# End Import Common Header 
# --------------------------

# Allow for optional flags of whether to use zsh or bash for the default shell
DF_SCRIPT_DIR="$CURRENT_FILE_DIR"

# Update package list and upgrade installed packages
print_line_break "Updating packages"
sudo apt update

print_line_break "Upgrading packages"
sudo apt upgrade -y

# Install snapd if necessary and request a restart
print_line_break "Installing snapd"
if ! command -v snap &> /dev/null; then
    print_info_message "Installing snapd"
    sudo apt install -y snapd
    print_info_message "snapd installed. A system restart is recommended to ensure snapd functions correctly."
    read -p "Would you like to restart now? (y/n): " RESTART_CHOICE
    if [[ "$RESTART_CHOICE" =~ ^[Yy]$ ]]; then
        print_info_message "Restarting system..."
        sudo reboot
    else
        print_info_message "Exiting. Please remember to restart your system later to ensure snapd functions correctly."
        exit 0
    fi
else
    print_info_message "snapd is already installed. Skipping installation."  
fi

# Install essential packages
print_line_break "Installing essential packages"
sudo apt install -y git curl wget 

# Set up Git configuration
sudo bash "$DF_SCRIPT_DIR/setup-git.sh" "$FULL_NAME" "$EMAIL_ADDRESS"

# Setup Fonts
sudo bash "$DF_SCRIPT_DIR/setup-fonts.sh"

# Setup Bash
sudo bash "$DF_SCRIPT_DIR/setup-bash.sh"

# Before setting up Alacritty, ensure Rust is installed
sudo bash "$DF_SCRIPT_DIR/setup-rust.sh"

# Before setting up Alacritty, ensure that VS Code is installed
sudo bash "$DF_SCRIPT_DIR/setup-vscode.sh"

# Setup a terminal emulator - Alacritty in this case
sudo bash "$DF_SCRIPT_DIR/setup-alacritty.sh"

# Setup Neovim and Lazyvim
sudo bash "$DF_SCRIPT_DIR/setup-neovim.sh"

# Setup Mullvad VPN
sudo bash "$DF_SCRIPT_DIR/setup-mullvad.sh"

# run the setup-docker.sh script to set up Docker using sudo rights
# Make sure to run the setup docker.sh script from the correct path - which should be the same directory as this script
sudo bash "$DF_SCRIPT_DIR/setup-docker.sh"

# Install Node.js and npm
sudo bash "$DF_SCRIPT_DIR/setup-node.sh"

# Install .NET SDK and Rider
sudo bash "$DF_SCRIPT_DIR/setup-dotnet-rider.sh" "$DOTNET_CORE_SDK_VERSION"

# Link configuration files
sudo bash "$DF_SCRIPT_DIR/link-dotfiles.sh"

# Clean up
print_line_break "Cleaning up"
sudo apt autoremove -y

print_line_break "Bootstrap completed. Please restart your terminal."

echo "Current user: $(whoami)"
echo "Home directory: $HOME"
echo "Shell: $SHELL"
