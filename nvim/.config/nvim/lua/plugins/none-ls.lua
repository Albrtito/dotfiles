-- none-ls plugin is refered as null_ls for all it's variables
local null_ls = require("null-ls")

null_ls.setup({
    sources = {
        null_ls.builtins.formatting.stylua,
        --null_ls.builtins.diagnostics.selene,
        --null_ls.builtins.diagnostics.pylint,
        null_ls.builtins.formatting.autopep8,
    },
})
-- KEYBINDS:
vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
