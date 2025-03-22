require("catppuccin").setup({
    background = { light = "latte", dark = "mocha" }, -- latte, frappe, macchiato, mocha
    term_colors = true,
    styles = {
        comments = { "italic" },
        keywords = { "italic" },
        booleans = { "italic" },
        numbers = {},
        types = {},
        strings = {},
        variables = {},
        properties = {},
    },
    show_end_of_buffer = true,
})

vim.cmd [[
" Colorscheme depends on plugins and needs to be set after plugins are loaded
if has('termguicolors') " Important
    set termguicolors
endif

" set background=dark " or light if you want light mode
colorscheme catppuccin
]]
