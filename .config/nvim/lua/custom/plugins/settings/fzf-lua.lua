require('fzf-lua').setup()

vim.cmd [[
nnoremap <leader>ff :FzfLua files<CR>
nnoremap <leader>fc :FzfLua files cwd=~/.config<CR>
nnoremap <leader>fg :FzfLua grep<CR>
]]
