-- Fast fuzzy finder for files, buffers, and text search
return {
    'ibhagwan/fzf-lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        require('fzf-lua').setup()
        vim.keymap.set('n', '<leader>f', '<cmd>FzfLua files<CR>', { desc = "Find files" })
        vim.keymap.set('n', '<leader>F', '<cmd>FzfLua files no_ignore=true<CR>',
            { desc = "Find all files (no ignore)" })
        vim.keymap.set('n', '<leader>ss', '<cmd>FzfLua live_grep<CR>', { desc = "Live grep" })
        vim.keymap.set('n', '<leader>sw', '<cmd>FzfLua grep_cword<CR>', { desc = "Grep current word" })
        vim.keymap.set('n', '<leader>sW', '<cmd>FzfLua grep_cWORD<CR>', { desc = "Grep current WORD" })
        vim.keymap.set('n', '<leader>t', '<cmd>FzfLua todos<CR>', { desc = "Find TODOs" })
    end
}