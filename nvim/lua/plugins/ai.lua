return {
	-- Copilot
--	{
--		"github/copilot.vim",
--		config = function()
--			vim.cmd(":Copilot disable")
--		end,
--	},
	-- Augment
	{
		"augmentcode/augment.vim",
		config = function()
            -- Take all on the current dir
			vim.g.augment_workspace_folders = {os.getenv("PWD")}
			vim.g.augment_disable_completions = true
		end,
	},
}
