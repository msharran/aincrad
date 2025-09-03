-- Lualine - Beautiful statusline with automatic dark/light theme support
return {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    opts = function()
        -- Dynamic Gruvbox colors that adapt to background setting
        local function get_gruvbox_colors()
            local is_dark = vim.o.background == 'dark'
            
            if is_dark then
                return {
                    bg = '#282828',          -- dark background
                    fg = '#ebdbb2',          -- light text
                    orange = '#fe8019',      -- bright orange
                    yellow = '#fabd2f',      -- bright yellow
                    aqua = '#8ec07c',        -- bright aqua
                    blue = '#83a598',        -- bright blue
                    red = '#fb4934',         -- bright red
                    green = '#b8bb26',       -- bright green
                    purple = '#d3869b',      -- bright purple
                    gray = '#a89984',        -- bright gray
                }
            else
                return {
                    bg = '#f9f5d7',          -- light cream background
                    fg = '#3c3836',          -- dark text
                    orange = '#d65d0e',      -- username/hostname segment
                    yellow = '#d79921',      -- directory segment  
                    aqua = '#689d6a',        -- git branch segment
                    blue = '#458588',        -- language/tools segment
                    red = '#cc241d',         -- errors/warnings
                    green = '#98971a',       -- success states
                    purple = '#b16286',      -- special states
                    gray = '#928374',        -- inactive elements
                }
            end
        end

        local colors = get_gruvbox_colors()

        -- Custom theme with proper contrast for both light and dark modes
        local gruvbox_powerline = {
            normal = {
                a = { bg = colors.orange, fg = colors.bg, gui = 'bold' },
                b = { bg = colors.yellow, fg = colors.bg },
                c = { bg = colors.bg, fg = colors.fg },
            },
            insert = {
                a = { bg = colors.green, fg = colors.bg, gui = 'bold' },
                b = { bg = colors.yellow, fg = colors.bg },
                c = { bg = colors.bg, fg = colors.fg },
            },
            visual = {
                a = { bg = colors.purple, fg = colors.bg, gui = 'bold' },
                b = { bg = colors.yellow, fg = colors.bg },
                c = { bg = colors.bg, fg = colors.fg },
            },
            command = {
                a = { bg = colors.blue, fg = colors.bg, gui = 'bold' },
                b = { bg = colors.yellow, fg = colors.bg },
                c = { bg = colors.bg, fg = colors.fg },
            },
            replace = {
                a = { bg = colors.red, fg = colors.bg, gui = 'bold' },
                b = { bg = colors.yellow, fg = colors.bg },
                c = { bg = colors.bg, fg = colors.fg },
            },
            inactive = {
                a = { bg = colors.gray, fg = colors.bg },
                b = { bg = colors.bg, fg = colors.gray },
                c = { bg = colors.bg, fg = colors.gray },
            },
        }


        return {
            options = {
                theme = gruvbox_powerline,
                component_separators = { left = '', right = '' },
                section_separators = { left = '', right = '' },
                disabled_filetypes = {
                    statusline = { 'help', 'startify', 'dashboard', 'oil' },
                },
                globalstatus = true,
            },
            sections = {
                lualine_a = {
                    {
                        'mode',
                        fmt = function(str)
                            return str:sub(1, 1)  -- Show only first character
                        end,
                    },
                },
                lualine_b = {},
                lualine_c = {
                    {
                        'filename',
                        path = 1,  -- Show relative path
                        symbols = {
                            modified = ' ●',
                            readonly = ' ',
                            unnamed = '[No Name]',
                        },
                    },
                },
                lualine_x = {
                    {
                        'filetype',
                        colored = true,
                        icon_only = false,
                        color = { bg = colors.blue, fg = colors.bg },
                    },
                },
                lualine_y = {
                    {
                        'progress',
                        color = { bg = colors.gray, fg = colors.bg },
                    },
                },
                lualine_z = {
                    {
                        'location',
                        color = { bg = colors.orange, fg = colors.bg, gui = 'bold' },
                    },
                },
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
        }
    end,
}