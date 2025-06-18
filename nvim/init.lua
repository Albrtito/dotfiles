require("keybinds")
require("options")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    { import = "plugins" },
    { import = "plugins.themes" },
})

-- Initialize the background theme server
local server_path = vim.fn.stdpath("config") .. "/lua/utils/server-theme.lua"
local command = "lua " .. server_path .. " &"
print("Executing command " .. command)
--os.execute(command)

vim.fn.jobstart({ "lua", server_path }, {
    detach = true,
    on_stdout = function(_, data)
        for _, line in ipairs(data) do
            if line ~= "" then
                print(line)
            end
        end
    end,
})
