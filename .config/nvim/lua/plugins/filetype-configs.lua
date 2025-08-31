-- Filetype-specific configurations and keymaps
return {
    "nvim-lua/plenary.nvim", -- dummy plugin to group filetype configs
    config = function()
        -- Python: Format with Black formatter
        vim.api.nvim_create_autocmd('FileType', {
            pattern = 'python',
            callback = function()
                vim.keymap.set('n', '<buffer> <Leader>lb', ':!black %<CR>',
                    { noremap = true, silent = true, desc = "Format with black" })
            end,
        })
    end
}