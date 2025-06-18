-- define common options
local opts = {
	noremap = true, -- non-recursive
	silent = true, -- do not show message
}

--LEADER
vim.g.mapleader = " "

-- RELOAD CONFIG
vim.keymap.set("n", "<leader>r", function()
	local config_path = vim.env.XDG_CONFIG_HOME .. "/nvim/init.lua"
	vim.cmd("source " .. config_path)
end, { desc = "Reload config" })

-----------------
-- Normal mode --
-----------------

-- Hint: see `:h vim.map.set()`
-- Better window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", opts)
vim.keymap.set("n", "<C-j>", "<C-w>j", opts)
vim.keymap.set("n", "<C-k>", "<C-w>k", opts)
vim.keymap.set("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
-- delta: 2 lines
vim.keymap.set("n", "<CS-Up>", ":resize -2<CR>", opts)
vim.keymap.set("n", "<CS-Down>", ":resize +2<CR>", opts)
vim.keymap.set("n", "<CS-Left>", ":vertical resize -2<CR>", opts)
vim.keymap.set("n", "<CS-Right>", ":vertical resize +2<CR>", opts)

-- Buffer navigation:
vim.keymap.set("n", "<leader>bn", ":bnext<CR>", opts)
vim.keymap.set("n", "<leader>bN", ":bprevious<CR>", opts)
vim.keymap.set("n", "<leader>bl", ":buffers<CR>", opts)
vim.keymap.set("n", "<leader>bd", ":bdelete<CR>", opts)
vim.keymap.set("n", "<leader>b#", ":b#<CR>", opts)

-- Tab navigation:
vim.keymap.set("n", "<Tab>", "gt", opts)
vim.keymap.set("n", "<leader>tn", ":tabnew<CR>", opts)
vim.keymap.set("n", "<leader>tc", ":tabclose<CR>", opts)

-----------------
-- Visual mode --
-----------------

-- Hint: start visual mode with the same area as the previous area and the same mode
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)
