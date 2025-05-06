return {
    -- Setup live preview with browser
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function()
            vim.fn["mkdp#util#install"]()
        end,
    },
    -- Setup render in files
    {
        "MeanderingProgrammer/render-markdown.nvim",
        dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" },
        --NOTE: IF used with obsidian remember to set obsidian ui off
        config = function()
            require("render-markdown").setup({
                file_types = { "markdown", "vimwiki" },
            })
            vim.treesitter.language.register("markdown", "vimwiki")
        end,
    }
}
