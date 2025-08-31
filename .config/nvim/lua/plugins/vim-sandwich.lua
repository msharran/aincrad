-- Powerful text object manipulation for surrounding characters
return {
    'machakann/vim-sandwich',
    config = function()
        vim.keymap.set('n', 's', '<Nop>')
        vim.keymap.set('x', 's', '<Nop>')
    end
}