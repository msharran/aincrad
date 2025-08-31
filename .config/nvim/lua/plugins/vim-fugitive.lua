-- Comprehensive Git integration for Vim
return {
    'tpope/vim-fugitive',
    config = function()
        vim.keymap.set('n', '<leader>gs', '<cmd>Git<cr>', { desc = "Git status (fugitive)" })
    end
}