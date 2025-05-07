require("neo-tree").setup({
    filesystem = {
        filtered_items = {
            hide_dotfiles = false,
            hide_gitignored = false,
        },
    }
})

vim.cmd [[
nnoremap <leader>ee :Neotree reveal toggle<cr>
nnoremap <leader>er :Neotree reveal<cr>
]]


