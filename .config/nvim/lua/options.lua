-- /Users/sharranm/aincrad/.config/nvim/lua/options.lua

local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true
opt.wrap = false
opt.swapfile = false
opt.backup = false
opt.undofile = true
opt.ignorecase = true
opt.termguicolors = true
opt.signcolumn = 'yes'
opt.updatetime = 50
opt.colorcolumn = '80'
opt.timeout = true
opt.timeoutlen = 300
opt.cursorline = true

-- Set search path
opt.path:append '**'
