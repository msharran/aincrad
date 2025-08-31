-- Treesitter configurations and abstraction layer
return {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
        require('nvim-treesitter.configs').setup {
            highlight = {
                enable = true,
            },
        }
    end
}