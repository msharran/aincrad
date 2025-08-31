-- A completion plugin for neovim coded in Lua
return {
    'hrsh7th/nvim-cmp',
    dependencies = {
        'hrsh7th/cmp-nvim-lsp', -- LSP source for nvim-cmp
        'hrsh7th/cmp-buffer',   -- Buffer completions
        'hrsh7th/cmp-path',     -- Path completions
        'hrsh7th/cmp-cmdline',  -- Command line completions
        'onsails/lspkind.nvim'  -- VSCode-like pictograms
    },
    config = function()
        local cmp = require('cmp')
        local lspkind = require('lspkind')
        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        cmp.setup({
            mapping = cmp.mapping.preset.insert({
                ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete(),
            }),
            sources = cmp.config.sources({
                { name = "nvim_lsp", keyword_length = 1 },
                { name = "path" },
            }, {
                { name = 'buffer' },
            }),
            formatting = {
                format = lspkind.cmp_format({
                    mode = "symbol",
                    max_width = 50,
                    symbol_map = { Copilot = "" }
                })
            },
        })
    end
}