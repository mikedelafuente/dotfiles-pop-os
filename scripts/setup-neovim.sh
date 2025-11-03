#!/bin/bash

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

echo "Neovim setup complete!"