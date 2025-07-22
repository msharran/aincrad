require('fzf-lua').setup()

vim.cmd [[
nnoremap <leader>f :FzfLua files<CR>
nnoremap <leader>F :FzfLua files no_ignore=true<CR>
nnoremap <leader>ss :FzfLua live_grep -s<CR>
nnoremap <leader>sw :FzfLua grep_cword -s<CR>
nnoremap <leader>sW :FzfLua grep_cWORD -s<CR>
nnoremap <leader>t :TodoFzfLua<CR>
]]
