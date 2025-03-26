require('fzf-lua').setup()

vim.cmd [[
nnoremap <leader>ff :FzfLua files<CR>
nnoremap <leader>fg :FzfLua grep<CR>
]]
