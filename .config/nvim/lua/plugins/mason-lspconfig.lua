-- Bridge between mason.nvim and lspconfig
return {
    'williamboman/mason-lspconfig.nvim',
    tag = 'v2.0.0',
    opts = {
        automatic_enable = true,
        ensure_installed = { "lua_ls", "basedpyright", "ruff", "gopls", "rust_analyzer", "zls" },
    }
}
