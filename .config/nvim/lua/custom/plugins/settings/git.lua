require('gitlinker').setup({ mappings = nil })
vim.cmd [[
nmap <leader>gy <CMD>lua require"gitlinker".get_buf_range_url("n", {})<CR>
vmap <leader>gy <CMD>lua require"gitlinker".get_buf_range_url("v", {})<CR>
nmap <leader>gb <CMD>lua require"gitlinker".get_buf_range_url("n", {action_callback = require"gitlinker.actions".open_in_browser})<CR>
vmap <leader>gb <CMD>lua require"gitlinker".get_buf_range_url("v", {action_callback = require"gitlinker.actions".open_in_browser})<CR>
nmap <leader>gY <CMD>lua require"gitlinker".get_repo_url()<CR>
nmap <leader>gB <CMD>lua require"gitlinker".get_repo_url({action_callback = require"gitlinker.actions".open_in_browser})<CR>
]]

require('gitsigns').setup({
    current_line_blame = true,             -- Toggle with `:Gitsigns toggle_current_line_blame`
    on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
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

        -- Actions
        map('v', '<leader>gr', function() gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end)
        map('n', '<leader>gR', gs.reset_buffer, { desc = "[G]it [R]eset buffer" })
        map('n', '<leader>gp', gs.preview_hunk, { desc = "[G]it [P]review hunk" })
        map('n', '<leader>gD', gs.toggle_deleted, { desc = "[G]it [D]eleted toggle" })
        map('n', '<leader>gd', gs.diffthis, { desc = "[G]it [D]iffthis" })
    end
})
