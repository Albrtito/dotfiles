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
					colorscheme = "kanagawa-wave",
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
				{
					name = "rose-pine",
					colorscheme = "rose-pine-dawn",
					before = [[
                    require("lualine").setup({
                    options = {theme = "rose-pine"}})
                    ]],
				},
				{
					name = "day-fox",
					colorscheme = "dayfox",
					before = [[
                    require("lualine").setup({
                    options = {theme = "dayfox"}})
                ]],
				},
				{
					name = "dawn-fox",
					colorscheme = "dawnfox",
					before = [[
                    require("lualine").setup({
                    options = {theme = "dawnfox"}})
                ]],
				},
				{
					name = "night-fox",
					colorscheme = "nightfox",
					before = [[
                    require("lualine").setup({
                    options = {theme = "nightfox"}})
                ]],
				},
				{
					name = "vim-paper",
					colorscheme = "paper",
					before = [[
                    require("lualine").setup({
                    options = {theme = "auto"}})
                    ]],
				},
			},
			livePreview = true,
		})
		local theme = os.getenv("THEME")
        print("Setting theme",theme)
		--theme = "catppuccin"
		th.setThemeByName(theme, true)
	end,
}
