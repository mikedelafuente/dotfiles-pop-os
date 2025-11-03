-- This is the main configuration file for Neovim
-- Set leader key
vim.g.mapleader = " "

-- Basic settings
vim.opt.number = true            -- Show line numbers
vim.opt.relativenumber = true    -- Show relative line numbers
vim.opt.expandtab = true         -- Use spaces instead of tabs
vim.opt.shiftwidth = 4           -- Number of spaces to use for each step of (auto)indent
vim.opt.tabstop = 4              -- Number of spaces that a <Tab> counts for

-- Enable syntax highlighting
vim.cmd('syntax on')

-- Set colorscheme
vim.cmd('colorscheme desert')

-- Plugins configuration
require('plugins')  -- Load plugins from the lua/plugins directory

-- Key mappings
vim.api.nvim_set_keymap('n', '<leader>ff', ':Telescope find_files<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fg', ':Telescope live_grep<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fb', ':Telescope buffers<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fh', ':Telescope help_tags<CR>', { noremap = true, silent = true })