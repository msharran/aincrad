-- Enable true color support
vim.opt.termguicolors = true

-- Configure gruvbox for a dark Warp-like theme
vim.opt.background = "dark"

require("mellifluous").setup({
    colorset = "tender"
})
vim.cmd("colorscheme mellifluous")
