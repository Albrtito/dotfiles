function getKeyByValue(filename, targetValue)
    print("Getting the new key")
    local valueToKey = {}

    -- Read and parse the file
    local file = io.open(filename, "r")
    if not file then
        error("Could not open file: " .. filename)
    end

    for line in file:lines() do
        local value, key = line:match("^(.-)=(.-)$")
        if value and key then
            valueToKey[value] = key
        end
    end
    file:close()

    -- Return the key for the given value
    return valueToKey[targetValue]
end

function loadValueKeyMap(filename)
    local valueToKey = {}
    local file = io.open(filename, "r")

    if not file then
        error("Could not open file: " .. filename)
    end

    for line in file:lines() do
        -- Trim whitespace and split on first '='
        line = line:match("^%s*(.-)%s*$") -- trim whitespace
        local value, key = line:match("^(.-)=(.-)$")
        if value and key then
            valueToKey[value] = key
        end
    end
    file:close()

    return valueToKey
end

return {
    "zaldih/themery.nvim",
    dependencies = {
        { "nvim-lualine/lualine.nvim" },
    },
    lazy = false,
    config = function()
        local th = require("themery")
        --require(vim.fn.stdpath("config") .. "/lua/utils/data")
        require("themery").setup({
            themes = {
                {
                    name = "catppuccin",
                    colorscheme = "catppuccin",
                    before = [[
                    require("lualine").setup({
                    options = {theme = "catppuccin-mocha"}})
                ]],
                },
                {
                    name = "kanagawa",
                    colorscheme = "kanagawa-wave",
                    before = [[
                    require("lualine").setup({
                    options = {theme = "kanagawa"}})
                    ]],
                },
                {
                    name = "cyberdream",
                    colorscheme = "cyberdream",
                    before = [[
                    require("lualine").setup({
                    options = {theme = "cyberdream"}})
                    ]],
                },
                {
                    name = "rose-pine",
                    colorscheme = "rose-pine-dawn",
                    before = [[
                    require("lualine").setup({
                    options = {theme = "rose-pine"}})
                    ]],
                },
                {
                    name = "day-fox",
                    colorscheme = "dayfox",
                    before = [[
                    require("lualine").setup({
                    options = {theme = "dayfox"}})
                ]],
                },
                {
                    name = "dawn-fox",
                    colorscheme = "dawnfox",
                    before = [[
                    require("lualine").setup({
                    options = {theme = "dawnfox"}})
                ]],
                },
                {
                    name = "night-fox",
                    colorscheme = "nightfox",
                    before = [[
                    require("lualine").setup({
                    options = {theme = "nightfox"}})
                ]],
                },
                {
                    name = "vim-paper",
                    colorscheme = "paper",
                    before = [[
                    require("lualine").setup({
                    options = {theme = "auto"}})
                    ]],
                },
                {
                    name = "sonokai",
                    colorscheme = "sonokai",
                    before = [[
                    require("lualine").setup({
                    options = {theme = "auto"}})
                    ]],
                },
            },
            livePreview = true,
        })

        local config_dir = os.getenv("XDG_CONFIG_HOME")
        local theme = getKeyByValue(config_dir .. "/global/data/settings.txt", "theme")
        print("Setting theme", theme)
        th.setThemeByName(theme, true)
    end,
}
