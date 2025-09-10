return {
	-- Setup mason
	{
		"williamboman/mason.nvim",
		lazy = false,
		config = function()
			local packages = {
				"black",
				"isort",
				"textlint",
				"clang-format",
				"checkmake",
				"shfmt",
				"sqlfluff",
				"stylua",
			}
			require("mason").setup({
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			})
			-- Install all packages in one command
			local registry = require("mason-registry")
			local function ensure_installed()
				for _, package in ipairs(packages) do
					if not registry.is_installed(package) then
						vim.cmd("MasonInstall " .. package)
					end
				end
			end
			-- Run the installation
			ensure_installed()
		end,
	},
	-- Setup lspconfig
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		opts = {
			auto_install = true,
		},
		config = function()
			require("mason-lspconfig").setup({
				-- A list of servers, formatters and linters to automatically install if they're not already installed
				ensure_installed = { "lua_ls", "clangd", "texlab", "bashls", "sqlls", "gopls" },
			})
		end,
	},
	-- Setup nvim-lspconfig
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		config = function()
			-- Configure diagnostics display
			vim.diagnostic.config({
				virtual_text = {
					enabled = true,
					source = "if_many",
					prefix = "●",
				},
				signs = true,
				underline = true,
				update_in_insert = false,
				severity_sort = true,
				float = {
					focusable = false,
					style = "minimal",
					border = "rounded",
					source = "always",
					header = "",
					prefix = "",
				},
			})

			-- Configure diagnostic signs
			local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
			end

			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			capabilities.offsetEncoding = { "utf-8" }
			local clangd_capabilities = vim.tbl_deep_extend("force", capabilities, { offsetEncoding = { "utf-8" } })

			-- Common on_attach function for all LSPs
			local on_attach = function(client, bufnr)
				-- Enable completion triggered by <c-x><c-o>
				vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

				-- Buffer local mappings
				local opts = { noremap = true, silent = true, buffer = bufnr }
				vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
				vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
				vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
			end

			local lspconfig = require("lspconfig")

			lspconfig.lua_ls.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				settings = {
					Lua = {
						runtime = {
							version = "LuaJIT",
						},
						diagnostics = {
							globals = { "vim" },
						},
						workspace = {
							library = vim.api.nvim_get_runtime_file("", true),
						},
						telemetry = {
							enable = false,
						},
					},
				},
			})

			lspconfig.pyright.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				settings = {
					python = {
						venvPath = ".",
						venv = ".venv",
						pythonPath = ".venv/bin/python",
						analysis = {
							autoSearchPaths = true,
							diagnosticMode = "workspace",
							useLibraryCodeForTypes = true,
						},
					},
				},
			})

			lspconfig.gopls.setup({
				capabilities = capabilities,
				single_file_support = true,
				root_dir = lspconfig.util.root_pattern("go.mod", ".git"),
			})

			lspconfig.clangd.setup({
				capabilities = clangd_capabilities,
				on_attach = on_attach,
				cmd = { "clangd", "--compile-commands-dir=build" },
				settings = {
					clangd = {
						compileCommands = "build/compile_commands.json",
						includePaths = {
							"/opt/homebrew/include",
						},
					},
				},
			})

			lspconfig.texlab.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				settings = {
					texlab = {
						auxDirectory = ".",
						bibtexFormatter = "texlab",
						build = {
							executable = "latexmk",
							args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
							onSave = false,
						},
						chktex = {
							onOpenAndSave = false,
							onEdit = false,
						},
						diagnosticsDelay = 300,
						formatterLineLength = 80,
						forwardSearch = {
							executable = nil,
							args = {},
						},
						latexFormatter = "latexindent",
						latexindent = {
							modifyLineBreaks = false,
						},
					},
				},
			})

			lspconfig.bashls.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				settings = {
					bashIde = {
						globPattern = "*@(.sh|.inc|.bash|.command)",
					},
				},
			})

			lspconfig.glsl_analyzer.setup({
				capabilities = clangd_capabilities,
				on_attach = on_attach,
			})

			lspconfig.sqlls.setup({
				capabilities = clangd_capabilities,
			})

			-- Global LSP keybinds
			vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Show hover documentation" })
			vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, { desc = "Go to definition" })
			vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, { desc = "Show references" })
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code actions" })
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })

			-- Diagnostic keybinds
			vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open diagnostic float" })
			vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
			vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
			vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic list" })

			-- Format keybind
			vim.keymap.set("n", "<leader>f", function()
				vim.lsp.buf.format({ async = true })
			end, { desc = "Format buffer" })
		end,
	},
}
