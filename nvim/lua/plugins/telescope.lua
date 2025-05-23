return {
	{
		"nvim-telescope/telescope-ui-select.nvim",
	},
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})
			-- KEYBINDS
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>p", function()
				require("telescope.builtin").find_files({
					hidden = false,
				})
			end, {})
			vim.keymap.set("n", "<leader>h", function()
				require("telescope.builtin").find_files({
					hidden = true,
				})
			end, {})
			--  vim.keymap.set("n", "<leader>p", builtin.find_files, {})
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
			vim.keymap.set("n", "<leader><leader>", builtin.oldfiles, {})

			require("telescope").load_extension("ui-select")
		end,
	},
}
