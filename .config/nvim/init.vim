" = Defaults before plugins =
let g:mapleader = " "
let g:maplocalleader = "\\"

" Disable netrw in favor of nvim-tree (must be early)
lua vim.g.loaded_netrw = 1
lua vim.g.loaded_netrwPlugin = 1

" == Plugins ==
lua require("custom.plugins.vimplug")
lua require("custom.plugins.settings")
