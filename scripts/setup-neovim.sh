#!/bin/bash

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


print_tool_setup_start "Neovim"

# This script sets up Neovim with the desired plugins and configurations.

# Check if Neovim is installed
if ! command -v nvim &> /dev/null; then
  print_info_message "Neovim is not installed. Installing Neovim."
  sudo apt install -y neovim
else
  print_info_message "Neovim is already installed. Skipping installation."
fi

# install lazy neovim setup
if [ ! -f "$HOME/.config/nvim/lua/config/lazy.lua" ]; then
  print_info_message "Installing Lazy.nvim"
  # required
  print_info_message "Backing up existing Neovim configuration if it exists."
  if [ -d "~/.config/nvim" ] || [ -d "~/.local/share/nvim" ] || [ -d "~/.local/state/nvim" ] || [ -d "~/.cache/nvim" ]; then
    print_action_message "Backing up existing Neovim configuration directories to *.bak"
    mv ~/.config/nvim{,.bak}
  fi

  # optional but recommended
  if [ -d "~/.local/share/nvim" ]; then
    mv ~/.local/share/nvim{,.bak}
  fi
  if [ -d "~/.local/state/nvim" ]; then
    mv ~/.local/state/nvim{,.bak}
  fi
  if [ -d "~/.cache/nvim" ]; then
    mv ~/.cache/nvim{,.bak}
  fi  

  git clone https://github.com/LazyVim/starter ~/.config/nvim

  rm -rf ~/.config/nvim/.git

  print_action_message "Start nvim and then run ':LazyHealth' to check if everything is set up correctly."

else
  print_info_message "Lazy.nvim is already installed. Skipping installation."
fi

# Create the necessary directories for Neovim configuration
mkdir -p ~/.config/nvim/lua/plugins

print_tool_setup_complete "Neovim"