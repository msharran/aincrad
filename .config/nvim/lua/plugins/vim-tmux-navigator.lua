-- Seamless navigation between tmux panes and vim splits
return {
    'christoomey/vim-tmux-navigator',
    config = function()
        vim.g.tmux_navigator_no_mappings = 1
    end
}