return {
	"epwalsh/obsidian.nvim",
	version = "*", -- recommended, use latest release instead of latest commit
	lazy = true,
	ft = "markdown",
	dependencies = {
		-- Required.
		"nvim-lua/plenary.nvim",
	},
	opts = {
		workspaces = {
			{
				name = "Notes",
				path = "/Users/tito/100495775@alumnos.uc3m.es - Google Drive/My Drive/2.UC3M/1.ObsidianNotes",
			},
		},
	},
}
