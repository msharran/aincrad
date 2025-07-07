require('fzf-lua').setup()

vim.cmd [[
nnoremap <leader>f :FzfLua files<CR>
nnoremap <leader>F :FzfLua files no_ignore=true<CR>
nnoremap <leader>s :FzfLua live_grep -s<CR>
nnoremap <leader>t :TodoFzfLua<CR>
]]
