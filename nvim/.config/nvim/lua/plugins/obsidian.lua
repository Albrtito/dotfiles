return {
	"epwalsh/obsidian.nvim",
	version = "*", -- recommended, use latest release instead of latest commit
	lazy = true,
	ft = "markdown",
	dependencies = {
		-- Required.
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local obsidian = require("obsidian")
		obsidian.setup({
			ui = { enable = false },

			workspaces = {
				{
					name = "Notes",
					path = "/Users/tito/100495775@alumnos.uc3m.es - Google Drive/My Drive/2.UC3M/1.ObsidianNotes",
				},
			},
			---@param url string
			follow_url_func = function(url)
				vim.fn.jobstart({ "open", url }) -- Mac OS
				-- vim.ui.open(url) -- need Neovim 0.10.0+
			end,
		})
	end,
}
