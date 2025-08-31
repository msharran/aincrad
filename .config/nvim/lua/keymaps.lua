-- /Users/sharranm/aincrad/.config/nvim/lua/keymaps.lua
-- Centralized keymappings

local keymap = vim.keymap.set

-- General
keymap('n', '<leader>y', '"+y', { desc = "Yank to system clipboard" })
keymap('v', '<leader>y', '"+y', { desc = "Yank to system clipboard" })
keymap('n', '<leader>p', '"+p', { desc = "Paste from system clipboard" })
keymap('n', 'Q', '<cmd>noh<CR>', { desc = "Clear search highlight" })
keymap('n', '<leader>x', '<cmd>silent !chmod +x %<CR>', { desc = "Make current file executable" })
keymap('n', '<leader>u', function() vim.fn.setreg('+', vim.fn.expand('<cfile>')) end, { desc = "Copy file path under cursor" })
keymap('n', '<leader>w', '<cmd>w<CR>', { desc = "Save file" })
keymap('n', '{', '{zz', { desc = "Move up and center" })
keymap('n', '}', '}zz', { desc = "Move down and center" })
keymap('n', '<C-d>', '<C-d>zz', { desc = "Scroll down and center" })
keymap('n', '<C-u>', '<C-u>zz', { desc = "Scroll up and center" })

-- Date and time
keymap('n', '<leader>D', 'ms:r !date "+%%d-%%m-%%Y"<CR>dW<Esc>`sp', { desc = "Insert date", noremap = false })
keymap('n', '<leader>T', 'ms:r !date "+%%d-%%m-%%Y %%H:%%M %%p %%Z"<CR>dW<Esc>`sp', { desc = "Insert date and time", noremap = false })

-- Window resizing
keymap('n', '<leader>wt', '<cmd>resize +5<CR>', { desc = "Increase window height" })
keymap('n', '<leader>ws', '<cmd>resize -5<CR>', { desc = "Decrease window height" })
keymap('n', '<leader>ww', '<cmd>vertical resize +5<CR>', { desc = "Increase window width" })
keymap('n', '<leader>wn', '<cmd>vertical resize -5<CR>', { desc = "Decrease window width" })

-- Insert Mode
keymap('i', 'jk', '<Esc>', { desc = "Escape insert mode" })
keymap('i', 'kj', '<Esc>', { desc = "Escape insert mode" })

-- Window navigation
keymap('n', '<C-h>', '<C-w>h', { desc = "Navigate window left" })
keymap('n', '<C-j>', '<C-w>j', { desc = "Navigate window down" })
keymap('n', '<C-k>', '<C-w>k', { desc = "Navigate window up" })
keymap('n', '<C-l>', '<C-w>l', { desc = "Navigate window right" })
keymap('i', '<C-h>', '<C-\\><C-N><C-w>h', { desc = "Navigate window left" })
keymap('i', '<C-j>', '<C-\\><C-N><C-w>j', { desc = "Navigate window down" })
keymap('i', '<C-k>', '<C-\\><C-N><C-w>k', { desc = "Navigate window up" })
keymap('i', '<C-l>', '<C-\\><C-N><C-w>l', { desc = "Navigate window right" })
keymap('t', '<C-h>', '<C-\\><C-N><C-w>h', { desc = "Navigate window left" })
keymap('t', '<C-j>', '<C-\\><C-N><C-w>j', { desc = "Navigate window down" })
keymap('t', '<C-k>', '<C-\\><C-N><C-w>k', { desc = "Navigate window up" })
keymap('t', '<C-l>', '<C-\\><C-N><C-w>l', { desc = "Navigate window right" })

-- Terminal maps
keymap('t', '<ESC>', '<C-\\><C-n>', { desc = "Normal Mode (terminal)" })


-- Plugin specific keymaps are defined in plugins.lua with the plugin spec

-- Autocommands
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Highlight on yank
augroup('highlight_yank', { clear = true })
autocmd('TextYankPost', {
  group = 'highlight_yank',
  pattern = '*',
  callback = function()
    vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 500 })
  end,
})

-- Auto open quickfix
augroup('quickfix', { clear = true })
autocmd('QuickFixCmdPost', {
  group = 'quickfix',
  pattern = '[^l]*',
  command = 'cwindow',
})
autocmd('QuickFixCmdPost', {
  group = 'quickfix',
  pattern = 'l*',
  command = 'lwindow',
})
