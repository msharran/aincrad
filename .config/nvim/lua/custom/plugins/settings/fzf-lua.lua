require("fzf-lua").setup({
    winopts = {
        split = "belowright new",
        backdrop         = 85,
    }
})

vim.cmd [[
nnoremap <C-p> <cmd>lua require('fzf-lua').files()<CR>
nnoremap <C-s> :FzfLua grep<CR>
nnoremap gw :FzfLua grep_cword<CR> 
nnoremap gW :FzfLua grep_cWORD<CR>
]]
