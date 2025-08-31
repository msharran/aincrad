-- Render markdown with treesitter highlighting in Neovim
return {
    'MeanderingProgrammer/render-markdown.nvim',
    opts = {
        completions = { lsp = { enabled = true } },
        filetypes = { "markdown", "codecompanion" },
    }
}