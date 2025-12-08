return {
  -- Your other plugins...

  {
    "ydkulks/cursor-dark.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("cursor-dark").setup({
        -- For theme
        style = "dark-midnight",
        -- For a transparent background
        transparent = true,
      })
      vim.cmd.colorscheme("cursor-dark")
    end,
  },
}
