return {
    "folke/noice.nvim",
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
        })

        require("notify").setup({
            render = "compact",
        })

       local notify = require("notify")
        vim.keymap.set("n", "<Leader>cn", notify.dismiss, {})
    end,

    dependencies = {

        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
    },
}
