return {
	-- Copilot
	{
		"github/copilot.vim",
		config = function()
			vim.cmd(":Copilot disable")
		end,
	},
	-- Augment
	{
		"augmentcode/augment.vim",
		config = function()
			vim.g.augment_workspace_folders = { "~/dotfiles/" }
			vim.g.augment_disable_completions = true
		end,
	},
}
