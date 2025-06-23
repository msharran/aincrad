---
allowed-tools: Bash(git status:*), Bash(git diff:*), Bash(git log:*), Bash(git commit:*)
description: Create detailed commit messages with context and preview before committing
---

# Commit Command Instructions

When creating commits, follow this process:

1. **Analyze the changes**: Use `git status` and `git diff` to understand what has changed
2. **Check recent commits**: Use `git log --oneline -10` to understand the repo's commit style
3. **Create descriptive commit message**:
   - Use appropriate prefixes based on the repo context (e.g., "config:", "feat:", "fix:", "refactor:")
   - Write clear, elaborate descriptions explaining what changed and why
   - Include technical details that represent the actual code changes
   - Never mention AI or automated assistance in the commit message
   - Follow the style of Mitchell Hashimoto's commits: clear title, detailed body explaining the changes and their impact

4. **Preview the commit message**: Always show the proposed commit message to the user for review before committing
5. **Commit behavior**:
   - If there are staged files, commit only those staged files
   - Do not automatically add untracked or unstaged files to the commit
   - Only commit what the user has intentionally staged

## Commit Message Format

```
prefix: Clear, descriptive title

Detailed explanation of what changed and why. Include:
- Technical implementation details
- Impact of the changes
- Any architectural decisions made
- Context for why the change was necessary

Additional technical details or edge cases handled.
```

## Example Commit Style (following Mitchell Hashimoto's approach)

```
macOS: Basic Read-Only Accessibility Integration

This integrates with macOS accessibility APIs to expose terminal
structure and content.

This is a very bare implementation and the terminal contents
currently reported are the full screen and scrollback which is way too
much for realistic human accessibility use. The target use case for this
is to enable automated tooling. However, this is all groundwork we'll
need to iterate and improve the accessibility work anyways.

To make this work, I also replatformed some of our hacky C APIs onto a
more robust API that can now read arbitrary ranges of the screen into
C strings for consumers to use.
```
