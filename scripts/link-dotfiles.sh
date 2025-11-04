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

print_tool_setup_start "Linking dotfiles"

# Create symbolic links for dotfiles in the home directory

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/home"

ln -sf "$DOTFILES_DIR/.bashrc" ~/.bashrc
ln -sf "$DOTFILES_DIR/.profile" ~/.profile
ln -sf "$DOTFILES_DIR/.gitconfig" ~/.gitconfig
ln -sf "$DOTFILES_DIR/.gitignore_global" ~/.gitignore_global

# Link .config files
mkdir -p ~/.config/Code/User
mkdir -p ~/.config/nvim/lua/plugins
mkdir -p ~/.config/lazydocker
mkdir -p ~/.config/lazygit

ln -sf "$DOTFILES_DIR/.config/Code/User/settings.json" ~/.config/Code/User/settings.json
# ln -sf "$DOTFILES_DIR/.config/nvim/init.lua" ~/.config/nvim/init.lua
# ln -sf "$DOTFILES_DIR/.config/nvim/lua/config/lazy.lua" ~/.config/nvim/lua/config/lazy.lua
ln -sf "$DOTFILES_DIR/.config/lazydocker/config.yml" ~/.config/lazydocker/config.yml
ln -sf "$DOTFILES_DIR/.config/lazygit/config.yml" ~/.config/lazygit/config.yml
ln -sf "$DOTFILES_DIR/.config/obsidian" ~/.config/obsidian
ln -sf "$DOTFILES_DIR/.config/openvpn" ~/.config/openvpn
ln -sf "$DOTFILES_DIR/.config/starship.toml" ~/.config/starship.toml

print_tool_setup_complete "Linking dotfiles"