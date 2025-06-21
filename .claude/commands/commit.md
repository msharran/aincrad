---
allowed-tools: Bash(git status:*), Bash(git diff:*), Bash(git log:*)
description: Analyze git changes and create a descriptive commit message
---

## Context
- Current git status: !`git status`
- Staged changes: !`git diff --cached`
- Unstaged changes: !`git diff`
- Recent commits for style reference: !`git log --oneline -5`

## Your task
Analyze the git changes above and create a descriptive commit message that:
1. Follows conventional commit format (type(scope): description)
2. Matches the existing commit style from the repository
3. Clearly describes what changed and why
4. Uses appropriate commit types: feat, fix, docs, style, refactor, test, chore
5. Don't add claude as co-author

After creating the commit message, ask if I want to proceed with committing using that message.
