-- Collection of small QoL plugins for Neovim
return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
        bigfile = { enabled = true },      -- Handle large files efficiently
        dashboard = { enabled = false },   -- Start screen (disabled)
        explorer = { enabled = true },     -- File explorer
        indent = { enabled = false },      -- Indent guides (disabled)
        input = { enabled = true },        -- Enhanced input dialogs
        picker = { enabled = true },       -- File/buffer picker
        notifier = { enabled = true },     -- Notification system
        quickfile = { enabled = true },    -- Quick file operations
        scope = { enabled = true },        -- Scope highlighting
        scroll = { enabled = false },      -- Smooth scrolling (disabled)
        statuscolumn = { enabled = true }, -- Enhanced status column
        words = { enabled = true },        -- Word highlighting
    },
}