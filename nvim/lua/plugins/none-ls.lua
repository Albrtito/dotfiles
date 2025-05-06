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

				-- Latex:
				-- Activate when using latex as most also work with md and dont want that
				-- Formatters
				null_ls.builtins.formatting.textlint, -- Formatting de LaTeX
				-- Linters:
				-- Code actions:
				--null_ls.builtins.code_actions.proselint, -- CA de LaTeX

				-- C/C++/make/cmake
				-- Formatters
				null_ls.builtins.formatting.clang_format, -- Formateador de C/C++
				-- Linters
				null_ls.builtins.diagnostics.checkmake, -- Linter de make

				-- SHELL
				null_ls.builtins.formatting.shfmt,

				-- SQL
				-- Formatters
				null_ls.builtins.formatting.sqlfluff.with({
					extra_args = { "--dialect", "oracle" }, -- Specify the SQL dialect
				}),
				--Linters: Oracle
				null_ls.builtins.diagnostics.sqlfluff.with({
					extra_args = { "--dialect", "oracle" }, -- Specify the SQL dialect
				}),
			},
		})
		--KEYBINDS:
		vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
	end,
}
