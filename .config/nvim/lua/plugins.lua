-- /Users/sharranm/aincrad/.config/nvim/lua/plugins.lua
return {
    -- General Editor Enhancements
    'nvim-lua/plenary.nvim',
    'tpope/vim-repeat',
    'tpope/vim-unimpaired',
    'tpope/vim-sensible',
    { 'numToStr/Comment.nvim',  opts = {} },
    {
        'christoomey/vim-tmux-navigator',
        config = function()
            vim.g.tmux_navigator_no_mappings = 1
        end
    },
    {
        'ThePrimeagen/harpoon',
        branch = 'harpoon2',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            local harpoon = require("harpoon")
            harpoon:setup()
            vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end, { desc = "Harpoon: Add file" })
            vim.keymap.set("n", "<leader>he", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
                { desc = "Harpoon: Toggle quick menu" })
            vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end, { desc = "Harpoon: Go to file 1" })
            vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end, { desc = "Harpoon: Go to file 2" })
            vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end, { desc = "Harpoon: Go to file 3" })
            vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end, { desc = "Harpoon: Go to file 4" })
        end
    },
    {
        'folke/todo-comments.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        opts = {
            keywords = {
                FIX = { icon = " ", color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
                TODO = { icon = " ", color = "info" },
                HACK = { icon = " ", color = "warning" },
                WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
                NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
                TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
            },
        }
    },
    {
        'machakann/vim-sandwich',
        config = function()
            vim.keymap.set('n', 's', '<Nop>')
            vim.keymap.set('x', 's', '<Nop>')
        end
    },

    -- File and Project Navigation
    {
        'ibhagwan/fzf-lua',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require('fzf-lua').setup()
            vim.keymap.set('n', '<leader>f', '<cmd>FzfLua files<CR>', { desc = "Find files" })
            vim.keymap.set('n', '<leader>F', '<cmd>FzfLua files no_ignore=true<CR>',
                { desc = "Find all files (no ignore)" })
            vim.keymap.set('n', '<leader>ss', '<cmd>FzfLua live_grep<CR>', { desc = "Live grep" })
            vim.keymap.set('n', '<leader>sw', '<cmd>FzfLua grep_cword<CR>', { desc = "Grep current word" })
            vim.keymap.set('n', '<leader>sW', '<cmd>FzfLua grep_cWORD<CR>', { desc = "Grep current WORD" })
            vim.keymap.set('n', '<leader>t', '<cmd>FzfLua todos<CR>', { desc = "Find TODOs" })
        end
    },
    'MunifTanjim/nui.nvim',
    {
        'stevearc/oil.nvim',
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            view_options = {
                show_hidden = true,
            }
        },
        config = function(_, opts)
            require("oil").setup(opts)
            vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
        end
    },

    -- Appearance and UI
    {
        'folke/tokyonight.nvim',
        priority = 1000,
        opts = {
            transparent = true,
            styles = {
                sidebars = "transparent",
                floats = "transparent",
            },
        },
        config = function()
            vim.opt.termguicolors = true
            vim.cmd.colorscheme 'tokyonight-night'
        end
    },
    'nvim-tree/nvim-web-devicons',
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            preset = "helix",
        },
        keys = {
            {
                "<leader>?",
                function()
                    require("which-key").show({ global = false })
                end,
                desc = "Buffer Local Keymaps (which-key)",
            },
        },
    },
    {
        'echasnovski/mini.indentscope',
        version = '*',
        opts = {
            symbol = '│',
        },
    },
    {
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
            completions = { lsp = { enabled = true } },
            filetypes = { "markdown", "codecompanion" },
        }
    },
    {
        'akinsho/bufferline.nvim',
        version = "*",
        opts = {
            options = {
                numbers = 'id',
            }
        },
        dependencies = {
            { 'nvim-tree/nvim-web-devicons' },
            { 'echasnovski/mini.icons',     version = '*', opts = {} },
            {
                "folke/snacks.nvim",
                priority = 1000,
                lazy = false,
                ---@type snacks.Config
                opts = {
                    -- your configuration comes here
                    -- or leave it empty to use the default settings
                    -- refer to the configuration section below
                    bigfile = { enabled = true },
                    dashboard = { enabled = false },
                    explorer = { enabled = true },
                    indent = { enabled = false },
                    input = { enabled = true },
                    picker = { enabled = true },
                    notifier = { enabled = true },
                    quickfile = { enabled = true },
                    scope = { enabled = true },
                    scroll = { enabled = false },
                    statuscolumn = { enabled = true },
                    words = { enabled = true },
                },
            },
        },
    },
    -- Git Integration
    {
        'tpope/vim-fugitive',
        config = function()
            vim.keymap.set('n', '<leader>gs', '<cmd>Git<cr>', { desc = "Git status (fugitive)" })
        end
    },
    {
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
    },
    {
        'lewis6991/gitsigns.nvim',
        opts = {
            current_line_blame = true,
            on_attach = function(bufnr)
                local gs = package.loaded.gitsigns
                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end
                map('n', ']g', function()
                    if vim.wo.diff then return ']g' end
                    vim.schedule(function() gs.next_hunk() end)
                    return '<Ignore>'
                end, { expr = true, desc = "Next Git Hunk" })
                map('n', '[g', function()
                    if vim.wo.diff then return '[g' end
                    vim.schedule(function() gs.prev_hunk() end)
                    return '<Ignore>'
                end, { expr = true, desc = "Prev Git hunk" })
                map('v', '<leader>gr', function() gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end,
                    { desc = "Git reset hunk" })
                map('n', '<leader>gR', gs.reset_buffer, { desc = "Git reset buffer" })
                map('n', '<leader>gp', gs.preview_hunk, { desc = "Git preview hunk" })
                map('n', '<leader>gD', gs.toggle_deleted, { desc = "Git deleted toggle" })
                map('n', '<leader>gd', gs.diffthis, { desc = "Git diffthis" })
            end
        }
    },
    { 'sindrets/diffview.nvim', dependencies = { 'nvim-lua/plenary.nvim' } },

    -- Language Support and LSP
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        config = function()
            require('nvim-treesitter.configs').setup {
                highlight = {
                    enable = true,
                },
            }
        end
    },
    {
        'williamboman/mason.nvim',
        opts = {}
    },
    {
        'williamboman/mason-lspconfig.nvim',
        tag = 'v2.0.0',
        opts = {
            automatic_enable = true,
            ensure_installed = { "lua_ls", "pyrefly", "gopls", "rust_analyzer", "zls" },
        }
    },
    {
        'neovim/nvim-lspconfig',
        config = function()
            local lspconfig = require("lspconfig")
            local capabilities = vim.tbl_deep_extend("force", {}, vim.lsp.protocol.make_client_capabilities(),
                require("cmp_nvim_lsp").default_capabilities())
            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('lsp_keymaps', { clear = true }),
                callback = function(e)
                    local opts = { buffer = e.buf }
                    vim.keymap.set("n", "gd", function() Snacks.picker.lsp_definitions() end,
                        vim.tbl_extend('force', opts, { desc = "Goto Definition" }))
                    vim.keymap.set("n", "gD", function() Snacks.picker.lsp_declarations() end,
                        vim.tbl_extend('force', opts, { desc = "Goto Declaration" }))
                    vim.keymap.set("n", "gr", function() Snacks.picker.lsp_references() end,
                        vim.tbl_extend('force', opts, { nowait = true, desc = "References" }))
                    vim.keymap.set("n", "gI", function() Snacks.picker.lsp_implementations() end,
                        vim.tbl_extend('force', opts, { desc = "Goto Implementation" }))
                    vim.keymap.set("n", "gy", function() Snacks.picker.lsp_type_definitions() end,
                        vim.tbl_extend('force', opts, { desc = "Goto T[y]pe Definition" }))
                    vim.keymap.set("n", "<leader>ls", function() Snacks.picker.lsp_symbols() end,
                        vim.tbl_extend('force', opts, { desc = "LSP Symbols" }))
                    vim.keymap.set("n", "<leader>lS", function() Snacks.picker.lsp_workspace_symbols() end,
                        vim.tbl_extend('force', opts, { desc = "LSP Workspace Symbols" }))

                    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end,
                        vim.tbl_extend('force', opts, { desc = "Show Hover" }))
                    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next() end,
                        vim.tbl_extend('force', opts, { desc = "Next Diagnostic" }))
                    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev() end,
                        vim.tbl_extend('force', opts, { desc = "Previous Diagnostic" }))
                    vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { silent = true, desc = "LSP Format Buffer" })
                    vim.keymap.set("n", "<leader>lr", function() vim.lsp.buf.rename() end,
                        vim.tbl_extend('force', opts, { desc = "LSP Rename" }))
                    vim.keymap.set("n", "<leader>la", function() vim.lsp.buf.code_action() end,
                        vim.tbl_extend('force', opts, { desc = "LSP Code Action" }))
                end
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
        end
    },
    { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },
    { 'folke/neodev.nvim', opts = {} },
    -- Autocompletion
    {
        'hrsh7th/nvim-cmp',
        dependencies = { 'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-buffer', 'hrsh7th/cmp-path', 'hrsh7th/cmp-cmdline', 'onsails/lspkind.nvim' },
        config = function()
            local cmp = require('cmp')
            local lspkind = require('lspkind')
            local cmp_select = { behavior = cmp.SelectBehavior.Select }
            cmp.setup({
                mapping = cmp.mapping.preset.insert({
                    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                    ["<C-Space>"] = cmp.mapping.complete(),
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp", keyword_length = 1 },
                    { name = "path" },
                }, {
                    { name = 'buffer' },
                }),
                formatting = {
                    format = lspkind.cmp_format({
                        mode = "symbol",
                        max_width = 50,
                        symbol_map = { Copilot = "" }
                    })
                },
            })
        end
    },

    -- AI and Copilot

    -- Filetype specific configurations
    {
        "nvim-lua/plenary.nvim", -- dummy plugin to group filetype configs
        config = function()
            -- Python keymap
            vim.api.nvim_create_autocmd('FileType', {
                pattern = 'python',
                callback = function()
                    vim.keymap.set('n', '<buffer> <Leader>lb', ':!black %<CR>',
                        { noremap = true, silent = true, desc = "Format with black" })
                end,
            })
        end
    }
}
