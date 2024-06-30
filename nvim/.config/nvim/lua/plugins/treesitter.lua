local config = require("nvim-treesitter.configs")
config.setup({
    ensure_installed = {"lua","python","c"},
    autoinstall = true,
    highlight = {enable = true},
    indent = {enable = true},
})

