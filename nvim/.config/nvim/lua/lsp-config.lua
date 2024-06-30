-- Setup mason
require('mason').setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

-- Setup lspconfig
require('mason-lspconfig').setup({
    -- A list of servers to automatically install if they're not already installed
    ensure_installed = { 'pylsp', 'lua_ls','clangd' },
})

-- Setup nvim-lspconfig
local lspconfig = require('lspconfig')
lspconfig.lua_ls.setup({})
lspconfig.pylsp.setup({})
lspconfig.clangd.setup({})
-- Keymaps for lsp-config
vim.keymap.set('n','K', vim.lsp.buf.hover, {})
vim.keymap.set('n','gd', vim.lsp.buf.definition,{})
vim.keymap.set({'n','v'}, '<leader>ca', vim.lsp.buf.code_action,{} )

