---
name: Commit Message Style
description: Commit/describe guidance derived from `./.claude/commands/*`
---

- Follow Mitchell Hashimoto's commit style: clear title, detailed body explaining the change and impact.
- Prefer Jujutsu (`jj`) for VCS operations:
  - Analyze with `jj st`, `jj log`, `jj diff`.
  - Create or update with `jj commit -m` / `jj desc -m`.
- If using `git`, analyze with `git status`/`git diff`, draft messages but avoid committing automatically.
- Do not mention AI or automation in commit messages.
- Focus messages on the "why" along with the "what".

Example style:

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
