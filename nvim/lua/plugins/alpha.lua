return {
    "goolord/alpha-nvim",
    config = function()
        -- Set the colorscheme
        vim.api.nvim_set_hl(0, "AlphaHeader", { fg = "#89B4FA" })    -- LightBlue
        vim.api.nvim_set_hl(0, "AlphaButton", { fg = "#CDD6F4" })    -- LightGrey
        vim.api.nvim_set_hl(0, "AlphaShortcut", { fg = "#A6ADC8" })  -- DarkGrey
        vim.api.nvim_set_hl(0, "AlphaFooter", { fg = "#FAB387" })    -- LightOrange
        vim.api.nvim_set_hl(0, "AlphaButtonContainer", { bg = "#1E1E2E" }) -- DarkBlue

        -- Set the header
        local logo_file = "logo-1"
        local logo_path = vim.fn.stdpath("config") .. "/lua/plugins/alpha/" .. logo_file .. ".txt"

        local function read_file(path)
            local file = io.open(path, "r")
            if not file then
                return nil
            end

            local lines = {}
            for line in file:lines() do
                table.insert(lines, line)
            end

            file:close()
            return lines
        end

        local header = {
            type = "text",
            val = read_file(logo_path) or { "Could not find: " .. logo_path },
            opts = {
                position = "center",
                hl = "AlphaHeader",
            },
        }
        -- Set the buttons
        local buttons = {
            type = "group",
            val = {
                {
                    type = "button",
                    val = "  New File",
                    on_press = function()
                        vim.cmd("ene!")
                    end,
                    opts = {
                        key = "n",
                        hl = "AlphaButton",
                        position = "center",
                    },
                },
                {
                    type = "button",
                    val = "  Find File",
                    on_press = function()
                        require("telescope.builtin").find_files()
                    end,
                    opts = {
                        key = "f",
                        hl = "AlphaButton",
                        position = "center",
                    },
                },
            },
            opts = {
                position = "center",
                spacing = 1,
                hl = "AlphaButtonContainer",
                width = "100%",
            },
        }
        -- Set the footer
        local function get_footer()
            local datetime = os.date(" %d-%m-%Y   %H:%M:%S")
            local lazy_stats = require("lazy").stats()
            local plugin_count = lazy_stats.count
            local version = vim.version()
            local nvim_version_info = string.format(" v%d.%d.%d", version.major, version.minor, version.patch)

            return datetime .. "   " .. plugin_count .. " plugins  " .. nvim_version_info
        end

        local footer = {
            type = "text",
            val = get_footer(),
            opts = {
                position = "center",
                hl = "AlphaFooter",
            },
        }

        -- Set the whole config:
        local layout = {
            { type = "padding", val = 9 },
            header,
            { type = "padding", val = 4 },
            buttons,
            { type = "padding", val = 4},
            footer,
        }

        local config = {
            layout = layout,
        }

        require("alpha").setup(config)
    end,
}
