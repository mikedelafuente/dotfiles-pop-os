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
print_tool_setup_start "Alacritty"

# Install Alacritty dependencies
print_info_message "Installing Alacritty dependencies"
 
 # Install rust and cargo if not already installed
if ! command -v cargo &> /dev/null; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source "$HOME/.cargo/env"
fi

# Leverage cargo to install Alacritty
if ! command -v alacritty &> /dev/null; then
    sudo apt install snapd
else
    print_info_message "Alacritty is already installed. Skipping installation."
fi

# Set the default terminal emulator to Alacritty
if [ "$TERM_PROGRAM" != "alacritty" ]; then
    print_info_message "Setting Alacritty as the default terminal emulator"
    # Update alternatives to set Alacritty as the default terminal
    sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator "$(which alacritty)" 50
    sudo update-alternatives --set x-terminal-emulator "$(which alacritty)"
else
    print_info_message "Alacritty is already the default terminal emulator. Skipping change."
fi  

print_tool_setup_complete "Alacritty"