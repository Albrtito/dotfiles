return {
	"zaldih/themery.nvim",
    dependencies = {"nvim-lualine/lualine.nvim"},
	lazy = false,
	config = function()
		local th = require("themery")
		require("themery").setup({
			themes = {
				{
					name = "catppuccin",
					colorscheme = "catppuccin",
					before = [[
                    require("lualine").setup({
                    options = {theme = "catppuccin-mocha"}})
                ]],
				},
				{
					name = "kanagawa",
					colorscheme = "kanagawa",
					before = [[
                    require("lualine").setup({
                    options = {theme = "kanagawa"}})
                    ]],
				},
				{
					name = "cyberdream",
					colorscheme = "cyberdream",
					before = [[
                    require("lualine").setup({
                    options = {theme = "cyberdream"}})
                    ]],
				},
			},
			livePreview = true,
		})
		local theme = os.getenv("THEME")
		--theme = "catppuccin"
		th.setThemeByName(theme, true)
	end,
}
