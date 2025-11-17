-- Quickstart configs for Nvim LSP
return {
    'neovim/nvim-lspconfig',
    dependencies = {
        {
            'folke/trouble.nvim',
            dependencies = { 'nvim-tree/nvim-web-devicons' },
            cmd = 'Trouble',
            opts = {
                -- Your configuration comes here
                -- or leave it empty to use the default settings
                auto_close = true, -- auto close when there are no items
                auto_open = false, -- auto open when there are items
                auto_preview = true, -- automatically open preview when on an item
                auto_refresh = true, -- auto refresh when open
                focus = true, -- Focus the window when opened
            },
            keys = {
                -- Diagnostics
                {
                    '<leader>ld',
                    '<cmd>Trouble diagnostics toggle<cr>',
                    desc = 'Diagnostics (Trouble)',
                },
                {
                    '<leader>lD',
                    '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
                    desc = 'Buffer Diagnostics (Trouble)',
                },
                -- LSP
                {
                    '<leader>ls',
                    '<cmd>Trouble symbols toggle focus=false<cr>',
                    desc = 'Symbols (Trouble)',
                },
                {
                    '<leader>ll',
                    '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
                    desc = 'LSP Definitions / references / ... (Trouble)',
                },
                -- Location list and Quickfix
                {
                    '<leader>lL',
                    '<cmd>Trouble loclist toggle<cr>',
                    desc = 'Location List (Trouble)',
                },
                {
                    '<leader>lQ',
                    '<cmd>Trouble qflist toggle<cr>',
                    desc = 'Quickfix List (Trouble)',
                },
            },
        }
    },
    config = function()
        local lspconfig = require("lspconfig")
        local capabilities = vim.tbl_deep_extend("force", {}, vim.lsp.protocol.make_client_capabilities(),
            require("cmp_nvim_lsp").default_capabilities())

        -- LSP keymaps setup when LSP attaches to buffer
        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('lsp_keymaps', { clear = true }),
            callback = function(e)
                local opts = { buffer = e.buf }

                vim.keymap.set("n", "gd", "<cmd>Trouble lsp_definitions<cr>",
                    vim.tbl_extend('force', opts, { desc = "Goto Definition" }))
                vim.keymap.set("n", "gD", "<cmd>Trouble lsp_declarations<cr>",
                    vim.tbl_extend('force', opts, { desc = "Goto Declaration" }))
                vim.keymap.set("n", "gr", "<cmd>Trouble lsp_references<cr>",
                    vim.tbl_extend('force', opts, { nowait = true, desc = "References (Trouble)" }))
                vim.keymap.set("n", "gI", "<cmd>Trouble lsp_implementations<cr>",
                    vim.tbl_extend('force', opts, { desc = "Implementations (Trouble)" }))
                vim.keymap.set("n", "gy", "<cmd>Trouble lsp_type_definitions<cr>",
                    vim.tbl_extend('force', opts, { desc = "Goto T[y]pe Definition" }))

                vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end,
                    vim.tbl_extend('force', opts, { desc = "Show Hover" }))
                vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { silent = true, desc = "LSP Format Buffer" })
                vim.keymap.set("n", "<leader>lr", function() vim.lsp.buf.rename() end,
                    vim.tbl_extend('force', opts, { desc = "LSP Rename" }))
                vim.keymap.set("n", "<leader>la", function() vim.lsp.buf.code_action() end,
                    vim.tbl_extend('force', opts, { desc = "LSP Code Action" }))
            end
        })

        -- Configure diagnostic display
        vim.diagnostic.config({
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
        })
    end
}
