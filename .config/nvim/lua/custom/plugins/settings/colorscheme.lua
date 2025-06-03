-- Enable true color support
vim.opt.termguicolors = true

-- Configure gruvbox for a dark Warp-like theme
require("gruvbox").setup({
  terminal_colors = true,
  undercurl = true,
  underline = true,
  bold = true,
  italic = {
    strings = true,
    emphasis = true,
    comments = true,
    operators = false,
    folds = true,
  },
  strikethrough = true,
  invert_selection = false,
  invert_signs = false,
  invert_tabline = false,
  invert_intend_guides = false,
  inverse = true,
  contrast = "hard", -- Hard contrast for darker background like Warp
  palette_overrides = {
    -- Darker background similar to Warp
    dark0_hard = "#0d1117",
    dark0 = "#161b22",
    dark0_soft = "#21262d",
    dark1 = "#30363d",
    dark2 = "#484f58",
    dark3 = "#6e7681",
    dark4 = "#8b949e",
    -- Accent colors similar to Warp's purple/blue theme
    bright_purple = "#a5a2ff",
    bright_blue = "#79c0ff",
    bright_aqua = "#39d353",
  },
  overrides = {
    -- Make background even darker like Warp
    Normal = { bg = "#0d1117" },
    NormalFloat = { bg = "#161b22" },
    FloatBorder = { bg = "#161b22", fg = "#6e7681" },
    -- Terminal-like colors for better contrast
    LineNr = { fg = "#6e7681" },
    CursorLineNr = { fg = "#a5a2ff", bold = true },
    Comment = { fg = "#8b949e", italic = true },
  },
})

vim.opt.background = "dark"
vim.cmd.colorscheme("gruvbox")
