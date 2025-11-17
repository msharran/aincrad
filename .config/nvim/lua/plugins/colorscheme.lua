return {
    "junegunn/seoul256.vim",
    config = function()
        vim.opt.termguicolors = true
        vim.opt.background = "dark"
        vim.cmd [[
        let g:seoul256_background = 236
        colorscheme seoul256
        ]]
    end,
}
