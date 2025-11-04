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


print_tool_setup_start "Neovim"

# This script sets up Neovim with the desired plugins and configurations.

# Create the necessary directories for Neovim configuration
mkdir -p ~/.config/nvim/lua/plugins

# Install Packer.nvim for managing Neovim plugins
if [ ! -d "~/.local/share/nvim/site/pack/packer/start/packer.nvim" ]; then
  git clone --depth 1 https://github.com/wbthomason/packer.nvim \
    ~/.local/share/nvim/site/pack/packer/start/packer.nvim
fi

# Create a basic init.lua configuration if it doesn't exist
if [ ! -f ~/.config/nvim/init.lua ]; then
  cat <<EOL > ~/.config/nvim/init.lua
-- Neovim configuration file

-- Load plugins
require('plugins')

-- Basic settings
vim.o.number = true
vim.o.relativenumber = true
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.tabstop = 2
EOL
fi

# Create a basic plugins.lua file if it doesn't exist
if [ ! -f ~/.config/nvim/lua/plugins/init.lua ]; then
  cat <<EOL > ~/.config/nvim/lua/plugins/init.lua
-- Plugin management with Packer
require('packer').startup(function(use)
  use 'wbthomason/packer.nvim' -- Package manager

  -- Add your plugins here
  -- Example: use 'nvim-treesitter/nvim-treesitter'
end)
EOL
fi

# Install plugins
nvim --headless +PackerSync +qa


print_tool_setup_complete "Neovim"