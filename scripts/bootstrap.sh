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
echo "Real user: $SUDO_USER"
echo "Home directory of real user: $(eval echo ~${SUDO_USER})" 
echo "Shell: $SHELL"
echo "Script directory: $(dirname -- "${BASH_SOURCE[0]}")"
echo "----------------------------------------"

if [ "$(whoami)" != "${SUDO_USER:-$(whoami)}" ]; then
    echo "Please start this script without sudo."
    exit 1
fi

# Run a sudo command early to prompt for the password
sudo -v


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
# Check how recent the last update was

LAST_APT_UPDATE=$(cat "$USER_HOME_DIR/.last_apt_update" 2>/dev/null || echo 0)
CURRENT_TIME=$(date +%s)
TIME_DIFF=$((CURRENT_TIME - LAST_APT_UPDATE))
# If more than 1 day (86400 seconds) has passed since the last update, perform update
if [ "$TIME_DIFF" -lt 86400 ]; then
    print_info_message "Last apt update was less than a day ago. Skipping update."
else
    print_info_message "Last apt update was more than a day ago. Performing update."
    sudo apt update
    # Write a file to ~/.last_apt_update with the current timestamp - completely overwrite any existing file
    echo "$(date +%s)" > "$USER_HOME_DIR/.last_apt_update"
fi

LAST_APT_UPGRADE=$(cat "$USER_HOME_DIR/.last_apt_upgrade" 2>/dev/null || echo 0)
CURRENT_TIME=$(date +%s)
TIME_DIFF=$((CURRENT_TIME - LAST_APT_UPGRADE))
# If more than 1 days (86400 seconds) has passed since the last upgrade, perform upgrade
if [ "$TIME_DIFF" -lt 86400 ]; then
    print_info_message "Last apt upgrade was less than a day ago. Skipping upgrade."
else
    print_info_message "Last apt upgrade was more than a day ago. Performing upgrade."
    sudo apt upgrade -y
  # Write a file to ~/.last_apt_upgrade with the current timestamp
  echo "$(date +%s)" > "$USER_HOME_DIR/.last_apt_upgrade"
fi

# Install essential packages
ESSENTIAL_PACKAGES=(git curl wget)
print_line_break "Installing essential packages"
for package in "${ESSENTIAL_PACKAGES[@]}"; do
    if ! dpkg -s "$package" &> /dev/null; then
        print_info_message "Installing $package"
        sudo apt install -y "$package"
    else
        print_info_message "$package is already installed. Skipping installation."
    fi
done

# Set up Git configuration
bash "$DF_SCRIPT_DIR/setup-git.sh" "$FULL_NAME" "$EMAIL_ADDRESS"

# Setup Fonts
bash "$DF_SCRIPT_DIR/setup-fonts.sh"

# Setup Bash
bash "$DF_SCRIPT_DIR/setup-bash.sh"

# Before setting up Alacritty, ensure Rust is installed
bash "$DF_SCRIPT_DIR/setup-rust.sh"

# Before setting up Alacritty, ensure that VS Code is installed
bash "$DF_SCRIPT_DIR/setup-vscode.sh"

# Setup a terminal emulator - Alacritty in this case
bash "$DF_SCRIPT_DIR/setup-alacritty.sh"

# Setup Neovim and Lazyvim
bash "$DF_SCRIPT_DIR/setup-neovim.sh"

# Setup Mullvad VPN
bash "$DF_SCRIPT_DIR/setup-mullvad.sh"

# run the setup-docker.sh script to set up Docker using sudo rights
# Make sure to run the setup docker.sh script from the correct path - which should be the same directory as this script
bash "$DF_SCRIPT_DIR/setup-docker.sh"

# Install Node.js and npm
bash "$DF_SCRIPT_DIR/setup-node.sh"

# Install .NET SDK and Rider
bash "$DF_SCRIPT_DIR/setup-dotnet-rider.sh" "$DOTNET_CORE_SDK_VERSION"

# Install Godot 4 Mono
bash "$DF_SCRIPT_DIR/setup-godot.sh"

# Install Postman
bash "$DF_SCRIPT_DIR/setup-postman.sh"

# Install Steam
bash "$DF_SCRIPT_DIR/setup-steam.sh"

# Install Discord
bash "$DF_SCRIPT_DIR/setup-discord.sh"

# Install Spotify
bash "$DF_SCRIPT_DIR/setup-spotify.sh"

# Install Obsidian
bash "$DF_SCRIPT_DIR/setup-obsidian.sh"

# Link configuration files
bash "$DF_SCRIPT_DIR/link-dotfiles.sh"

# Clean up
print_line_break "Cleaning up"
sudo apt autoremove -y

print_line_break "Bootstrap completed. Please restart your terminal."

echo "Shell: $SHELL"
