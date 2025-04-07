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

				-- Latex
				-- Formatters
				null_ls.builtins.formatting.latexindent, -- Formateador de LaTeX
				null_ls.builtins.formatting.bibtex, -- Formateador de LaTeX
				-- Linters
				null_ls.builtins.diagnostics.vale, -- Linter de LaTeX
				null_ls.builtins.diagnostics.proselint, -- Linter de LaTeX

				-- C/C++
				-- Formatters
				null_ls.builtins.formatting.clang_format, -- Formateador de C/C++
				-- Linters
				null_ls.builtins.diagnostics.clangtidy, -- Linter de C/C++

                -- SQL
                -- Formatters
                null_ls.builtins.formatting.sql_formatter, -- Formateador de SQL
                -- Linters: Oracle
                null_ls.builtins.diagnostics.sqlfluff.with({
                    extra_args = { "--dialect", "oracle" }, -- Specify the SQL dialect
                }),
			},
		})
		--KEYBINDS:
		vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
	end,
}
