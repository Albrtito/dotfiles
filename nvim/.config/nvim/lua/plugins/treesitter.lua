-- Setup the treesitter plugin
local config = require("nvim-treesitter.configs")
config.setup({
    ensure_installed = {"lua","python","c"},
    highlight = {enable = true},
    indent = {enable = true},
})  

