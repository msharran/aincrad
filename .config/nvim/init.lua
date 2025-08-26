-- /Users/sharranm/aincrad/.config/nvim/init.lua

-- Set leader keys
vim.g.mapleader = ' '
vim.g.maplocalleader = ''

-- Load options
require('options')

-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1


-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load plugins and keymaps
require("lazy").setup("plugins")
require("keymaps")

