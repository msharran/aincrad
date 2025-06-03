set -gx ANTHROPIC_BASE_URL 'https://api.labs.dreamplug.net/anthropic'
set -gx ANTHROPIC_AUTH_TOKEN (gpg --decrypt ~/.secrets/OPENAPITOKEN.gpg)

abbr -a cc4 'claude --model claude-sonnet-4-20250514'