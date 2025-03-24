require("codecompanion").setup({
    adapters = {
        copilot = function()
            return require("codecompanion.adapters").extend("copilot", {
                schema = {
                    model = {
                        default = "claude-3.7-sonnet",
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
        },
        inline = {
            adapter = "copilot",
        },
        agent = {
            adapter = "copilot",
        },
    },
})
