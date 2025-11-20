return {
    "folke/noice.nvim",
    dependencies = {

        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
    },
    config = function()
        require("noice").setup({
            -- add any options here
            routes = {
                {
                    filter = {
                        event = "msg_show",
                        any = {
                            { find = "%d+L, %d+B" },
                            { find = "; after #%d+" },
                            { find = "; before #%d+" },
                            { find = "%d fewer lines" },
                            { find = "%d more lines" },
                        },
                    },
                    opts = { skip = true },
                },
            },

            views = {
                cmdline_popup = {
                    position = {
                        row = 8,
                        col = "50%",
                    },
                    size = {
                        width = 60,
                        height = "auto",
                    },
                },
                popupmenu = {
                    relative = "editor",
                    position = {
                        row = 11,
                        col = "50%",
                    },
                    size = {
                        width = 60,
                        height = 10,
                    },
                    border = {
                        style = "rounded",
                        padding = { 0, 1 },
                    },
                    win_options = {
                        winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
                    },
                },
            },
        })

        require("notify").setup({
            --render = "compact",
        })

        local notify = require("notify")
        vim.keymap.set("n", "<Leader>cm", notify.dismiss, {})
    end,
}
