return {
    "ydkulks/cursor-dark.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("cursor-dark")
      require("cursor-dark").setup({
        -- For theme
        -- style = "dark-midnight",
        -- For a transparent background
        -- transparent = true,
      })
    end,
  }
