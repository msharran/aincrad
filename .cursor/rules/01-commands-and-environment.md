---
name: Commands and Environment
description: Preferred tools and execution context
---

- Prefer `fd` over `find` and `rg` (ripgrep) over `grep`.
- Prefer `jj` (Jujutsu) over `git` where possible.
- Be explicit about execution context. If an operation targets the VM, run it via `ssh vm`.
- Avoid long-lived/interactive background processes in automated steps.
