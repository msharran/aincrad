return {
    "rebelot/kanagawa.nvim",
    config = function()
        vim.opt.termguicolors = true
        vim.opt.background = "dark"
        vim.cmd("colorscheme kanagawa-wave")
    end,
}
