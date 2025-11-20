return {
	-- install with yarn or npm
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "cd app && yarn install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
        vim.keymap.set("n","<leader>mp", ":MarkdownPreviewToggle<CR>")
	},
	-- Setup render in files
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" },
		--NOTE: IF used with obsidian remember to set obsidian ui off
		config = function()
			require("render-markdown").setup({
				file_types = { "markdown", "vimwiki" },
			})
			vim.treesitter.language.register("markdown", "vimwiki")
		end,
	},
	{
		"junegunn/goyo.vim",
		config = function()
			-- Goyo settings
			vim.g.goyo_width = "60%"
			vim.g.goyo_height = "90%"

			-- Goyo integration - completely hide lualine
			local function goyo_enter()
				require("lualine").hide()
				vim.opt.showtabline = 0 -- Hide the tabline completely
				vim.opt.laststatus = 0
			end

			local function goyo_leave()
				require("lualine").hide({ unhide = true })
				vim.opt.showtabline = 2 -- Show tabline again
				vim.opt.laststatus = 0 -- Keep statusline disabled
			end

			vim.api.nvim_create_autocmd("User", {
				pattern = "GoyoEnter",
				callback = goyo_enter,
			})

			vim.api.nvim_create_autocmd("User", {
				pattern = "GoyoLeave",
				callback = goyo_leave,
			})
		end,
	},
	{
		"preservim/vim-pencil",
		ft = "markdown",
		config = function()
			vim.g["pencil#wrapModeDefault"] = "soft"
			vim.cmd("PencilSoft") -- Activa Pencil automáticamente
		end,
	},
}
