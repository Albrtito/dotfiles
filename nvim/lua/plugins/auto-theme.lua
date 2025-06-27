return {
    "f-person/auto-dark-mode.nvim",
    dependencies = { "zaldih/themery.nvim", "EdenEast/nightfox.nvim" },
    opts={
        set_dark_mode = function()
            local th = require("themery")
            th.setThemeByName("nightfox", true)
            --vim.cmd([[colorscheme nightfox]])
        end,
        set_light_mode = function()
            local th = require("themery")
            th.setThemeByName("dayfox", true)
            --vim.cmd([[colorscheme dayfox]])
        end,
        fallback = "dark",
    },
}

--    config = function()
--        require("auto-dark-mode").opts({
--            set_dark_mode = function()
--                local th = require("themery")
--                th.setThemeByName("nightfox", true)
--                --vim.cmd([[colorscheme nightfox]])
--            end,
--            set_light_mode = function()
--                local th = require("themery")
--                th.setThemeByName("dayfox", true)
--                --vim.cmd([[colorscheme dayfox]])
--            end,
--            fallback = "dark",
--        })
--    end,
