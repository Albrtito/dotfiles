
 -- List of pluginst installed by lazy
 return {
    -- Catppuccin theme plugin
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
    -- Telescope plugin
    {
    'nvim-telescope/telescope.nvim', tag = '0.1.5',
      dependencies = { 'nvim-lua/plenary.nvim' }
    },
    -- Treesitter plugin
    {"nvim-treesitter/nvim-treesitter",build = ":TSUpdate"},

    -- Neo-Tree plugin
    {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
        -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
        }
    }
    
}

