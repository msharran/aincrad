return {
    "ayu-theme/ayu-vim",
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
        vim.cmd [[
        let ayucolor="dark"   " for dark version of theme
        colorscheme ayu
        ]]
    end
}
