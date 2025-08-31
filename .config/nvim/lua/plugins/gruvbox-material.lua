-- Gruvbox Material - Eye-friendly colorscheme with superior contrast
return {
    'sainnhe/gruvbox-material',
    lazy = false,
    priority = 1000,
    config = function()
        -- Eye-friendly settings for optimal comfort
        vim.g.gruvbox_material_background = 'medium'  -- Softer than 'hard', easier on eyes
        vim.g.gruvbox_material_palette = 'material'   -- Enhanced Material Design palette
        vim.g.gruvbox_material_enable_italic = 1      -- Better typography with italics
        vim.g.gruvbox_material_enable_bold = 1        -- Enhanced readability
        vim.g.gruvbox_material_disable_italic_comment = 0  -- Keep italic comments for distinction
        vim.g.gruvbox_material_cursor = 'auto'        -- Better cursor visibility
        vim.g.gruvbox_material_transparent_background = 0  -- Solid background for comfort
        vim.g.gruvbox_material_current_word = 'grey background'  -- Subtle word highlighting
        vim.g.gruvbox_material_statusline_style = 'material'  -- Consistent statusline
        vim.g.gruvbox_material_lightline_disable_bold = 0    -- Keep bold in statusline
        vim.g.gruvbox_material_better_performance = 1        -- Optimized performance
        
        -- Enable true color support for accurate colors
        if vim.fn.has("termguicolors") == 1 then
            vim.opt.termguicolors = true
        end
        
        -- Set light background for better eye comfort
        vim.opt.background = "dark"

        -- Apply the colorscheme
        vim.cmd.colorscheme('gruvbox-material')
    end,
}
