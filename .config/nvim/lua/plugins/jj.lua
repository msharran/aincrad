-- Jujutsu version control integration for Neovim
return {
    "nicolasgb/jj.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "folke/snacks.nvim" },
    config = function()
        require("jj").setup({
            -- editor_mode = "buffer",
        })

        -- Main keymaps for jj operations
        vim.keymap.set("n", "<leader>jl", "<cmd>J log<cr>", { desc = "jj: Log" })
        vim.keymap.set("n", "<leader>js", "<cmd>J status<cr>", { desc = "jj: Status" })
        vim.keymap.set("n", "<leader>je", "<cmd>J describe<cr>", { desc = "jj: Describe" })
        vim.keymap.set("n", "<leader>jd", "<cmd>J diff<cr>", { desc = "jj: Diff" })
        vim.keymap.set("n", "<leader>jc", "<cmd>J commit<cr>", { desc = "jj: Commit (checkpoint)" })
        vim.keymap.set("n", "<leader>ju", "<cmd>J undo<cr>", { desc = "jj: Undo" })
        vim.keymap.set("n", "<leader>jn", "<cmd>J new<cr>", { desc = "jj: New change" })
    end
}
