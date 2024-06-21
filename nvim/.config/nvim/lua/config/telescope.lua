-- Call the setup of telescope and setup the keybinds
local builtin = require("telescope.builtin")
vim.keymap.set('n', '<leader>p', builtin.find_files, {})
vim.keymap.set('n','<leader>fg' ,builtin.live_grep, {})
