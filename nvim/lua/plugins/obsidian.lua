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
		-- Set all keybinds:
		vim.keymap.set("n", "<leader>on", ":ObsidianNew<CR>", {})
		vim.keymap.set("n", "<leader>os", ":ObsidianSearch<CR>", {})
		vim.keymap.set("n", "<leader>ob", ":ObsidianBacklinks<CR>", {})
		obsidian.setup({
			ui = { enable = false },
			open_notes_in = "vsplit",
			workspaces = {
				{
					name = "Uni",
					path = "/Users/tito/100495775@alumnos.uc3m.es - Google Drive/My Drive/2.UC3M/1.ObsidianNotes",
					overrides = {
						notes_subdir = "02-Atomic",
						new_notes_location = "notes_subdir",
					},
				},
			},
			attachments = {
				-- The default folder to place images in via `:ObsidianPasteImg`.
				img_folder = "99-Meta/00. Attachments",
			},
			---@param url string
			follow_url_func = function(url)
				vim.fn.jobstart({ "open", url }) -- Mac OS
				-- vim.ui.open(url) -- need Neovim 0.10.0+
			end,

			-- customize how note IDs are generated given an optional title.
			---@param title string|?
			---@return string
			note_id_func = function(title)
				-- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
				-- In this case a note with the title 'My new note' will be given an ID that looks
				-- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
				local suffix = ""
				if title ~= nil then
					-- If title is given, transform it into valid file name.
					suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
				else
					-- If title is nil, just add 4 random uppercase letters to the suffix.
					for _ = 1, 4 do
						suffix = suffix .. string.char(math.random(65, 90))
					end
				end
				return tostring(os.time()) .. "-" .. suffix
			end,
		})
	end,
}
