require("codecompanion").setup({
    adapters = {
        copilot = function()
            return require("codecompanion.adapters").extend("copilot", {
                schema = {
                    model = {
                        -- default = "claude-3.7-sonnet",
                        default = "gemini-2.5-pro",
                    },
                },
            })
        end,
        openai = function()
            return require("codecompanion.adapters").extend("openai", {
                env = {
                    api_key = "cmd:gpg --decrypt ~/.secrets/OPENAPITOKEN.gpg",
                },
                schema = {
                    model = {
                        default = "claude-3.7-sonnet",
                    },
                },
            })
        end,
    },
    strategies = {
        chat = {
            adapter = "copilot",
            slash_commands = {
                ["file"] = {
                    -- Location to the slash command in CodeCompanion
                    callback = "strategies.chat.slash_commands.file",
                    description = "Select a file using FZF",
                    opts = {
                        provider = "fzf_lua", -- Can be "default", "telescope", "fzf_lua", "mini_pick" or "snacks"
                        contains_code = true,
                    },
                },
            },
        },
        inline = {
            adapter = "copilot",
        },
        agent = {
            adapter = "copilot",
        },
    },
})
