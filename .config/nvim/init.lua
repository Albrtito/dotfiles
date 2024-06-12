-- Some initial changes for tabs: turning one tab into 4 spaces
vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.g.mapleader = " "

-- Add lazy package manager. 
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
local opts = {}

require("lazy").setup("plugins")

-- Call the setup of telescope and setup the keybinds
local builtin = require("telescope.builtin")
vim.keymap.set('n', '<leader>p', builtin.find_files, {})
vim.keymap.set('n','<leader>fg' ,builtin.live_grep, {})

-- Call the setup of catppuccin 
require("catppuccin").setup()
vim.cmd.colorscheme "catppuccin"

-- Setup the treesitter plugin
local config = require("nvim-treesitter.configs")
config.setup({
    ensure_installed = {"lua","python","c"},
    highlight = {enable = true},
    indent = {enable = true},
})  

-- Setup for neotree
vim.keymap.set('n','<leader>n', ':Neotree filesystem reveal left<CR>')
