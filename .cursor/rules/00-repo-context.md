---
name: Repo Context
description: High-level architecture and context for Aincrad dotfiles
---

- Host: macOS (Apple Silicon). Guest: Ubuntu ARM Server via UTM.
- Networking: UTM Emulated VLAN; SSH port-forward Host:2022 → Guest:22.
- Connect to the VM using `ssh vm` (configured in `.ssh/config`).
- This repo is dotfiles. Treat `~/.claude` as `./.claude` within this workspace.
- Core configs: `.config/` (starship, zed, nvim, lazygit, ghostty, aerospace, etc.).
- Key scripts: `sbin/` (`tmux-sessioniser` alias `t`, `zed-sessioniser`, `zellij-sessionizer`, `nwm`).
- Bootstrap and VM setup helpers live under `bootstrap/`.
