require('neodev').setup()

-- Setup treesitter
require('nvim-treesitter.configs').setup {
    -- a list of parser names, or "all"
    ensure_installed = { "vimdoc", "javascript", "typescript", "c", "lua", "rust", "go", "bash", "python", "templ" },

    -- install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- automatically install missing parsers when entering buffer
    -- recommendation: set to false if you don't have `tree-sitter` cli installed locally
    auto_install = false,

    highlight = {
        -- `false` will disable the whole extension
        enable = true,

        -- setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- using this option may slow down your editor, and you may see some duplicate highlights.
        -- instead of true it can also be a list of languages
        additional_vim_regex_highlighting = { "markdown" },
    },
}


-- Create a new autogroup for LSP keymaps
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('lsp_keymaps', {}),
    callback = function(e)
        local opts = { buffer = e.buf }
        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end,
            vim.tbl_extend('force', opts, { desc = "Go to Definition" }))
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end,
            vim.tbl_extend('force', opts, { desc = "Show Hover" }))
        vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end,
            vim.tbl_extend('force', opts, { desc = "Show references" }))
        vim.keymap.set("n", "gI", function() vim.lsp.buf.implementation() end,
            vim.tbl_extend('force', opts, { desc = "Show implementations" }))
        vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next() end,
            vim.tbl_extend('force', opts, { desc = "Next Diagnostic" }))
        vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev() end,
            vim.tbl_extend('force', opts, { desc = "Previous Diagnostic" }))

        -- l stands for LSP
        vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { silent = true, desc = "[L]SP [F]ormat Buffer" })
        vim.keymap.set("n", "<leader>ls", function() vim.lsp.buf.workspace_symbol() end,
            vim.tbl_extend('force', opts, { desc = "[L]SP [W]orkspace [S]ymbol" }))
        vim.keymap.set("n", "<leader>lr", function() vim.lsp.buf.rename() end,
            vim.tbl_extend('force', opts, { desc = "[L]SP [R]ename" }))
        vim.keymap.set("n", "<leader>la", function() vim.lsp.buf.code_action() end,
            vim.tbl_extend('force', opts, { desc = "[L]SP [C]ode [A]ction" }))
    end
})

-- Setup NVIM LSP
local lspconfig = require("lspconfig")
local capabilities = vim.tbl_deep_extend("force", {}, vim.lsp.protocol.make_client_capabilities(),
    require("cmp_nvim_lsp").default_capabilities())

require("fidget").setup({})
require("mason").setup()

require("mason-lspconfig").setup({
    ensure_installed = { "lua_ls", "pyrefly", "gopls", "rust_analyzer", "zls" },
    automatic_installation = true,
})

vim.diagnostic.config({
    float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
    },
})
