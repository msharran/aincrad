-- Generate shareable file permalinks for Git hosting services
return {
    'ruifm/gitlinker.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
        mappings = nil,
        callbacks = {
            ["github.work"] = function(url_data)
                url_data.host = "github.com"
                return require "gitlinker.hosts".get_github_type_url(url_data)
            end
        },
    },
    config = function(_, opts)
        require('gitlinker').setup(opts)
        vim.keymap.set('n', '<leader>gy', function() require "gitlinker".get_buf_range_url("n", {}) end,
            { desc = "Copy git link" })
        vim.keymap.set('v', '<leader>gy', function() require "gitlinker".get_buf_range_url("v", {}) end,
            { desc = "Copy git link" })
        vim.keymap.set('n', '<leader>gb',
            function()
                require "gitlinker".get_buf_range_url("n",
                    { action_callback = require "gitlinker.actions".open_in_browser })
            end,
            { desc = "Open git link in browser" })
        vim.keymap.set('v', '<leader>gb',
            function()
                require "gitlinker".get_buf_range_url("v",
                    { action_callback = require "gitlinker.actions".open_in_browser })
            end,
            { desc = "Open git link in browser" })
        vim.keymap.set('n', '<leader>gY', function() require "gitlinker".get_repo_url() end,
            { desc = "Copy repo URL" })
        vim.keymap.set('n', '<leader>gB',
            function()
                require "gitlinker".get_repo_url({
                    action_callback = require "gitlinker.actions"
                        .open_in_browser
                })
            end, { desc = "Open repo in browser" })
    end
}