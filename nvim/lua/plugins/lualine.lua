return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
        print(vim.cmd("colorscheme"))
		require("lualine").setup({
			options = {
				icons_enabled = true,
				theme = "catppuccin-mocha",
				component_separators = "|",
				section_separators = "",
				--component_separators = { left = "", right = "" },
				--section_separators = { left = "", right = "" },
			},
			tabline = {
				lualine_a = { "mode" },
				--lualine_b = {"buffers"},
				lualine_x = { "filename","filetype" },
				lualine_y = { "location" },
				lualine_z = {
					{
						"datetime",
						-- options: default, us, uk, iso, or your own format string ("%H:%M", etc..)
						style = "default",
					},
				},
			},
			sections = {},
		})
	end,
}
