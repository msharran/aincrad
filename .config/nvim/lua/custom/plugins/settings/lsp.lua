require('neodev').setup()

-- Setup treesitter
require('nvim-treesitter.configs').setup {
    -- a list of parser names, or "all"
    ensure_installed = { "vimdoc", "javascript", "typescript", "c", "lua", "rust", "go", "bash", "templ" },

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

-- Setup NVIM LSP
local lspconfig = require("lspconfig")
local capabilities = vim.tbl_deep_extend("force", {}, vim.lsp.protocol.make_client_capabilities(),
    require("cmp_nvim_lsp").default_capabilities())
require("fidget").setup({})
require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = {},
    handlers = {
        function(server_name) -- default handler (optional)
            lspconfig[server_name].setup {
                capabilities = capabilities
            }
        end,
        ["lua_ls"] = function()
            lspconfig.lua_ls.setup {
                capabilities = capabilities,
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim", "it", "describe", "before_each", "after_each" },
                        }
                    }
                }
            }
        end,
        -- Setup golang
        ["gopls"] = function()
            lspconfig.gopls.setup {
                capabilities = capabilities,
                settings = {
                    gopls = {
                        analyses = {
                            unusedparams = true,
                        },
                        staticcheck = true,
                    },
                },
            }
        end,
        -- Setup python
        ["pylsp"] = function()
            lspconfig.pylsp.setup {
                settings = {
                    pylsp = {
                        plugins = {
                            pycodestyle = {
                                ignore = { 'E501' },
                                maxLineLength = 100
                            }
                        }
                    }
                }
            }
        end,
    }
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
