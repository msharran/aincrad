-- ~/.config/nvim/lua/custom/plugins/vimplug.lua
--
-- This file manages the plugins for Neovim using the vim-plug plugin manager.
-- For more information on vim-plug, see: https://github.com/junegunn/vim-plug
--
-- To add a new plugin, add a new `Plug` line to the `call plug#begin()` block.
-- To remove a plugin, remove the corresponding `Plug` line.
--
-- After modifying this file, restart Neovim to automatically install or remove plugins.

vim.cmd [[
call plug#begin()

" =============================================================================
" General Editor Enhancements
" =============================================================================
Plug 'nvim-lua/plenary.nvim'         " Lua utility library, a dependency for many other plugins.
Plug 'tpope/vim-repeat'              " Enables repeating plugin actions with the '.' command.
Plug 'tpope/vim-unimpaired'          " Provides complementary pairs of mappings (e.g., `[b` and `]b` for buffers).
Plug 'tpope/vim-sensible'            " A set of sensible default settings for Vim.
Plug 'numToStr/Comment.nvim'         " Smart and powerful commenting plugin.
Plug 'christoomey/vim-tmux-navigator' " Seamless navigation between Vim splits and Tmux panes.
Plug 'ThePrimeagen/harpoon' , { 'branch': 'harpoon2' } " Quickly navigate to frequently used files.
Plug 'folke/todo-comments.nvim'      " Highlight and search for TODO, FIXME, etc. comments.
Plug 'machakann/vim-sandwich'

" =============================================================================
" File and Project Navigation
" =============================================================================
Plug 'ibhagwan/fzf-lua'               " Fuzzy finder for files, buffers, git, etc., powered by fzf.
Plug 'MunifTanjim/nui.nvim'           " UI component library, a dependency for neo-tree.
Plug 'nvim-tree/nvim-tree.lua'        " Fast and configurable file explorer

" =============================================================================
" Appearance and UI
" =============================================================================
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'nvim-tree/nvim-web-devicons'   " Adds file-type icons to various plugins.
Plug 'folke/which-key.nvim'          " Displays a popup with possible keybindings.
Plug 'lukas-reineke/indent-blankline.nvim' " Adds indentation guides.
Plug 'MeanderingProgrammer/render-markdown.nvim' " Renders markdown in neovim.

" =============================================================================
" Git Integration
" =============================================================================
Plug 'tpope/vim-fugitive'             " A premier Git wrapper for Vim.
Plug 'ruifm/gitlinker.nvim'           " Generates shareable permalinks to Git repositories.
Plug 'lewis6991/gitsigns.nvim'        " Shows Git decorations in the sign column.
Plug 'sindrets/diffview.nvim'         " A powerful Git diff viewer.

" =============================================================================
" Language Support and LSP (Language Server Protocol)
" =============================================================================
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' } " Advanced syntax highlighting and code analysis.
Plug 'williamboman/mason.nvim'        " Manages LSP servers, DAP servers, linters, and formatters.
Plug 'williamboman/mason-lspconfig.nvim', { 'tag': 'v2.0.0' } " Bridges mason.nvim and lspconfig - pinned to v1.31.0 for setup_handlers support
Plug 'neovim/nvim-lspconfig'          " Configurations for the built-in LSP client.
Plug 'j-hui/fidget.nvim'              " Standalone UI for LSP progress.
Plug 'folke/neodev.nvim'              " Provides full signature help and completion for the Neovim Lua API.
Plug 'fatih/vim-go'                   " Go development plugin for Vim.

" =============================================================================
" Autocompletion
" =============================================================================
Plug 'hrsh7th/nvim-cmp'               " The core autocompletion engine.
Plug 'hrsh7th/cmp-nvim-lsp'           " LSP source for nvim-cmp.
Plug 'hrsh7th/cmp-buffer'             " Buffer source for nvim-cmp.
Plug 'hrsh7th/cmp-path'               " Filesystem path source for nvim-cmp.
Plug 'hrsh7th/cmp-cmdline'            " Command-line source for nvim-cmp.
Plug 'onsails/lspkind.nvim'           " Adds file-type pictograms to completion items.

" =============================================================================
" AI and Copilot
" =============================================================================
Plug 'github/copilot.vim'             " GitHub Copilot integration.
Plug 'yetone/avante.nvim', { 'branch': 'main', 'do': 'make' } " AI-powered code assistant.

call plug#end()

" =============================================================================
" Auto-installation of Plugins
" =============================================================================
" This function checks if any plugins are missing and installs them automatically
" when Neovim starts. It then quits Neovim, and you will need to restart it.
function! s:install_plugins()
  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
    PlugInstall --sync | q
    echom 'Plugins installed successfully, restart Neovim.'
  endif
endfunction

" Run the auto-install function on startup.
autocmd VimEnter * call s:install_plugins()
]]
