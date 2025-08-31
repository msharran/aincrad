-- Quickstart configs for Nvim LSP
return {
    'neovim/nvim-lspconfig',
    config = function()
        local lspconfig = require("lspconfig")
        local capabilities = vim.tbl_deep_extend("force", {}, vim.lsp.protocol.make_client_capabilities(),
            require("cmp_nvim_lsp").default_capabilities())

        -- LSP keymaps setup when LSP attaches to buffer
        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('lsp_keymaps', { clear = true }),
            callback = function(e)
                local opts = { buffer = e.buf }
                vim.keymap.set("n", "gd", function() Snacks.picker.lsp_definitions() end,
                    vim.tbl_extend('force', opts, { desc = "Goto Definition" }))
                vim.keymap.set("n", "gD", function() Snacks.picker.lsp_declarations() end,
                    vim.tbl_extend('force', opts, { desc = "Goto Declaration" }))
                vim.keymap.set("n", "gr", function() Snacks.picker.lsp_references() end,
                    vim.tbl_extend('force', opts, { nowait = true, desc = "References" }))
                vim.keymap.set("n", "gI", function() Snacks.picker.lsp_implementations() end,
                    vim.tbl_extend('force', opts, { desc = "Goto Implementation" }))
                vim.keymap.set("n", "gy", function() Snacks.picker.lsp_type_definitions() end,
                    vim.tbl_extend('force', opts, { desc = "Goto T[y]pe Definition" }))
                vim.keymap.set("n", "<leader>ls", function() Snacks.picker.lsp_symbols() end,
                    vim.tbl_extend('force', opts, { desc = "LSP Symbols" }))
                vim.keymap.set("n", "<leader>lS", function() Snacks.picker.lsp_workspace_symbols() end,
                    vim.tbl_extend('force', opts, { desc = "LSP Workspace Symbols" }))

                vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end,
                    vim.tbl_extend('force', opts, { desc = "Show Hover" }))
                vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next() end,
                    vim.tbl_extend('force', opts, { desc = "Next Diagnostic" }))
                vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev() end,
                    vim.tbl_extend('force', opts, { desc = "Previous Diagnostic" }))
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