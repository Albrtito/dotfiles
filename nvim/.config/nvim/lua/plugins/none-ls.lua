return {
    "nvimtools/none-ls.nvim",
    config = function()
        local null_ls = require("null-ls")
        null_ls.setup({
            sources = {
                -- Lua
                null_ls.builtins.formatting.stylua,
                --null_ls.builtins.diagnostics.selene,

                -- Python
                null_ls.builtins.formatting.black,
                null_ls.builtins.formatting.isort,
                --null_ls.builtins.diagnostics.pylint,
                --null_ls.builtins.formatting.autopep8,
            },
        })
        --KEYBINDS:
        vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
    end,
}
