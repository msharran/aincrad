require('fzf-lua').setup()

-- Create a new autogroup for LSP keymaps
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('lsp_keymaps', {}),
    callback = function(e)
        local opts = { buffer = e.buf }
        vim.keymap.set("n", "gd", ":FzfLua lsp_definitions<CR>",
            vim.tbl_extend('force', opts, { desc = "Go to Definition" }))

        vim.keymap.set("n", "gD", ":FzfLua lsp_declarations<CR>",
            vim.tbl_extend('force', opts, { desc = "Go to declarations" }))

        vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end,
            vim.tbl_extend('force', opts, { desc = "Show Hover" }))

        vim.keymap.set("n", "gr", ":FzfLua lsp_references<CR>",
            vim.tbl_extend('force', opts, { desc = "Show references", silent = true }))

        vim.keymap.set("n", "gI", ":FzfLua lsp_implementations<CR>",
            vim.tbl_extend('force', opts, { desc = "Show implementations" }))

        vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next() end,
            vim.tbl_extend('force', opts, { desc = "Next Diagnostic" }))

        vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev() end,
            vim.tbl_extend('force', opts, { desc = "Previous Diagnostic" }))

        -- l stands for LSP
        vim.keymap.set("n", "<leader>ld", ":FzfLua lsp_document_diagnostics<CR>",
            { silent = true, desc = "[L]SP [D]ocument Diagnostics" })

        vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format,
            { silent = true, desc = "[L]SP [F]ormat Buffer" })

        vim.keymap.set("n", "<leader>lw", function() vim.lsp.buf.workspace_symbol() end,
            vim.tbl_extend('force', opts, { desc = "[L]SP [W]orkspace Symbol" }))

        vim.keymap.set("n", "<leader>lr", function() vim.lsp.buf.rename() end,
            vim.tbl_extend('force', opts, { desc = "[L]SP [R]ename" }))

        vim.keymap.set("n", "<leader>la", ":FzfLua lsp_code_actions<CR>",
            vim.tbl_extend('force', opts, { desc = "[L]SP Code [A]ction" }))
    end
})

vim.cmd [[
nnoremap <leader>f :FzfLua files<CR>
nnoremap <leader>s :FzfLua grep<CR>
nnoremap <leader>t :TodoFzfLua<CR>
]]
