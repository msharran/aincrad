---
allowed-tools: Bash(jj st:*), Bash(jj diff:*), Bash(jj log:*), Bash(jj desc:*)
description: Create detailed description of the current changes using Mitchell's style
---

# Describe Command Instructions

When creating commits, follow this process:

- **Analyze the changes**: Use `jj st`, `jj log` and `jj diff` to understand what has changed
- Update the description using `jj desc -m` command
- Follow Mitchell Hashimoto's commit message style (refer the example given below) to create the change description.
- Use Jujutsu instead of git CLI: https://steveklabnik.github.io/jujutsu-tutorial/

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
