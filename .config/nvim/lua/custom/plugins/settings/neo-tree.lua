require("neo-tree").setup({
    filesystem = {
        filtered_items = {
            hide_dotfiles = false,
            hide_gitignored = false,
        },
    }
})

vim.cmd [[
nnoremap <leader>ee :Neotree toggle reveal_force_cwd left<cr>
nnoremap <leader>eb :Neotree toggle show buffers right<cr>
nnoremap <leader>eg :Neotree float git_status<cr>
]]


