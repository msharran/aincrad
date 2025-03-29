require("neo-tree").setup({
    filesystem = {
        filtered_items = {
            hide_dotfiles = false,
            hide_gitignored = false,
        },
    }
})

vim.cmd [[
nnoremap <leader>e :Neotree reveal float toggle<cr>
]]


