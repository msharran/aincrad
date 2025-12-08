-- Simple lualine with onedark theme
return {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    opts = {
        options = {
            theme = 'onehalfdark',
            component_separators = '',
            section_separators = '',
            disabled_filetypes = {
                statusline = { 'help', 'startify', 'dashboard', 'oil' },
            },
            globalstatus = true,
        },
        sections = {
            lualine_a = { 'mode' },
            lualine_b = {},
            lualine_c = { 'filename' },
            lualine_x = { 'filetype' },
            lualine_y = { 'progress' },
            lualine_z = { 'location' },
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = { 'filename' },
            lualine_x = { 'location' },
            lualine_y = {},
            lualine_z = {},
        },
        extensions = { 'oil', 'fugitive', 'man' },
    },
}
