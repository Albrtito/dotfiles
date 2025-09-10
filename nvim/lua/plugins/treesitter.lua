return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            local config = require("nvim-treesitter.configs")
            config.setup({
                ensure_installed = {"lua", "python", "c","bash","go"},
                ignore_install = {"latex"},
                auto_install = true,
                highlight = { enable = true, disable={"latex"} },
                indent = { enable = true },
                fold= { enable = true },
            })
        end,
    },
}
