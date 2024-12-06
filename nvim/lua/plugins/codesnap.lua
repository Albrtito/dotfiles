return {
	"mistricky/codesnap.nvim",
	build = "make build_generator",
	keys = {
		{
			"<leader>cc",
			"<cmd>CodeSnap<cr>",
			mode = "x",
			desc = "Save selected code snapshot into clipboard",
		},
		{
			"<leader>cs",
			"<cmd>CodeSnapSave<cr>",
			mode = "x",
			desc = "Save selected code snapshot in ~/Pictures",
		},
	},
	config = function()
		require("codesnap").setup({
			save_path = os.getenv("XDG_PICTURES_DIR") or (os.getenv("HOME") .. "/Pictures"),
			has_breadcrumbs = true,
			bg_theme = "bamboo",
			bg_padding = 0,
            mac_window_bar = false,
		})
	end,
}
