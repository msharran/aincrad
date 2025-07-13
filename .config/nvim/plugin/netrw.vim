" Break down the following command:
"   :let @z=expand("%:t")<CR> - Get the current file name and store it in register z
"   :Ex<CR> - Open the file explorer
"   /<C-R>z<CR> - Search for the file name in the file explorer
"   :noh<CR> - Clear the search highlight
nnoremap <leader>e :let @z=expand("%:t")<CR>:Ex<CR>/<C-R>z<CR>:noh<CR>
" Refer ftplugin/netrw.vim for related mappings


" List style = Tree
let g:netrw_liststyle = 3
