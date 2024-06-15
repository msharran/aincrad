return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            require("custom.setup_ux")
        end,
        dependencies = {
            { "folke/which-key.nvim",       event = "VeryLazy", },
            { 'chentoast/marks.nvim', opt = {} },
            { "norcalli/nvim-colorizer.lua", opt = {} },
            {
                'MeanderingProgrammer/markdown.nvim',
                dependencies = { 'nvim-treesitter/nvim-treesitter' },
            },
            {
                'stevearc/oil.nvim',
                dependencies = { "nvim-tree/nvim-web-devicons" },
            }
        }
    },
}
