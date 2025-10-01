return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        print(vim.cmd("colorscheme"))

        require("lualine").setup({
            options = {
                icons_enabled = true,
                --theme = "catpuccin-mocha",
                component_separators = "|",
                section_separators = "",
                --component_separators = { left = "", right = "" },
                --section_separators = { left = "", right = "" },
            },
            tabline = {
                lualine_a = {{ "mode", separator = { left = "" }, right_padding = 2 }},
                lualine_b = { "tabs" },
                --lualine_b = {"buffers"},
                lualine_x = {
                    {
                        "filename",
                        file_status = true,        -- Displays file status (readonly status, modified status)
                        newfile_status = false,    -- Display new file status (new file means no write after created)
                        path = 1,                  -- 0: Just the filename
                        symbols = {
                            modified = "[+]",      -- Text to show when the file is modified.
                            readonly = "[-]",      -- Text to show when the file is non-modifiable or readonly.
                            unnamed = "[No Name]", -- Text to show for unnamed buffers.
                            newfile = "[New]",     -- Text to show for newly created file before first write
                        },
                    },
                    { "filetype" },
                },
                lualine_y = { "location", "selectioncount" },
                lualine_z = {
                    {
                        "datetime",
                        -- options: default, us, uk, iso, or your own format string ("%H:%M", etc..)
                        style = "default",
                        separator = { right = "" },
                    },
                },
            },

            sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = {},
                lualine_x = {},
                lualine_y = {},
                lualine_z = {},
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = {},
                lualine_x = {},
                lualine_y = {},
                lualine_z = {},
            },
            winbar = {},
        })
        -- Force override after lualine loads
        vim.schedule(function()
            vim.opt.laststatus = 0
            vim.cmd("set laststatus=0")
        end)
    end,
}
