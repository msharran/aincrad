-- Enable true color support
vim.opt.termguicolors = true

require("mellifluous").setup({
    colorset = "tender"
})
vim.cmd("colorscheme mellifluous")
