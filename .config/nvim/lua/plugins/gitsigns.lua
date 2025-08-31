-- Git signs and hunk management in the sign column
return {
    'lewis6991/gitsigns.nvim',
    opts = {
        current_line_blame = true,
        on_attach = function(bufnr)
            local gs = package.loaded.gitsigns
            local function map(mode, l, r, opts)
                opts = opts or {}
                opts.buffer = bufnr
                vim.keymap.set(mode, l, r, opts)
            end
            map('n', ']g', function()
                if vim.wo.diff then return ']g' end
                vim.schedule(function() gs.next_hunk() end)
                return '<Ignore>'
            end, { expr = true, desc = "Next Git Hunk" })
            map('n', '[g', function()
                if vim.wo.diff then return '[g' end
                vim.schedule(function() gs.prev_hunk() end)
                return '<Ignore>'
            end, { expr = true, desc = "Prev Git hunk" })
            map('v', '<leader>gr', function() gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end,
                { desc = "Git reset hunk" })
            map('n', '<leader>gR', gs.reset_buffer, { desc = "Git reset buffer" })
            map('n', '<leader>gp', gs.preview_hunk, { desc = "Git preview hunk" })
            map('n', '<leader>gD', gs.toggle_deleted, { desc = "Git deleted toggle" })
            map('n', '<leader>gd', gs.diffthis, { desc = "Git diffthis" })
        end
    }
}