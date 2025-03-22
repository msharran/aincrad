require("nvim-tree").setup({
    sort = {
        sorter = "case_sensitive",
    },
    view = {
        width = 35,
    },
    renderer = {
        group_empty = true,
    },
    filters = {
        git_ignored = false,
    }
})

vim.cmd [[
nnoremap <Leader>ee :NvimTreeFindFileToggle<CR>
nnoremap <Leader>ef :NvimTreeFindFile<CR>
]]
