# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## System Architecture

**Aincrad** is a dotfiles repository for a MacOS-to-Linux development workflow. The architecture follows a host-guest pattern:

- **Host OS**: MacOS on Apple Silicon
- **Guest OS**: Ubuntu ARM Server via UTM virtualization
- **Network**: Emulated VLAN with SSH port forwarding (Host:2022 → Guest:22)
- **Connection**: SSH via `ssh vm` using configuration in `.ssh/config`

## Development Commands

### Bootstrap Commands
```bash
# Bootstrap host (MacOS) - installs git-crypt, imports GPG keys
make host/bootstrap

# Bootstrap guest VM (Ubuntu) - requires EXPORTED_GPG_ZIP environment variable
make vm/bootstrap

# Copy secrets to VM (requires EXPORTED_GPG_ZIP path)
make vm/copy-secrets

# Install dotfiles with stow (unlocks git-crypt, creates symlinks, sets SSH permissions)
make aincrad/install

# Dry run installation (preview symlinks without creating them)
make aincrad/dryrun

# Clean/uninstall symlinks
make aincrad/clean

# List installed symlinks
make aincrad/ls
```

### Required Environment Variables
```bash
# Path to exported GPG keys zip file (required for VM bootstrap)
export EXPORTED_GPG_ZIP=~/Downloads/sharran-gpg-20250316T104202Z-001.zip

# SSH host for VM connection (defaults to 'vm')
export VM_SSH_HOST=vm
```

### Project/Session Management
```bash
# Terminal session switcher (tmux)
t                    # fuzzy find and switch to project
t ~/path/to/dir      # jump directly to specific path

# Zed session switcher
# Use Ctrl-S in Zed workspace to launch zed-sessioniser
```

## Configuration Structure

### Core Configurations
- `.config/starship.toml` - Starship prompt configuration
- `.config/zed/` - Zed editor settings, keymaps, and tasks
- `.config/nvim/` - Neovim configuration with custom Lua plugins
- `.config/lazygit/` - Git UI configuration
- `.config/ghostty/` - Terminal emulator configuration
- `.config/aerospace/` - Tiling window manager for MacOS

### Key Scripts
- `sbin/tmux-sessioniser` - Project session management for tmux (aliased as `t`)
- `sbin/zed-sessioniser` - Project session management for Zed
- `sbin/zellij-sessionizer` - Project session management for Zellij
- `sbin/nwm` - Network window manager utility
- `sbin/warp-launch-config-generator.sh` - Warp terminal configuration generator
- `bootstrap/vm.sh` - Ubuntu VM setup script with development tools
- `bootstrap/import_gpg.sh` - GPG key import automation

## Editor Integration

### Zed Editor Tasks
The following tasks are configured in `.config/zed/tasks.json`:
- `claude-code` - Launch Claude Code CLI
- `claude-code-continue` - Continue previous session
- `claude-code-resume` - Resume previous session
- `zed-sessioniser` - Project switcher (Ctrl-S)
- `lazygit` - Git UI (Ctrl-B G)
- `k9s stage/central` - Kubernetes management with AWS profiles

### Key Bindings (Zed)
- `Ctrl-S` - Project sessioniser
- `Ctrl-B Ctrl-C` - Claude Code
- `Ctrl-B G` - Lazygit
- `Ctrl-H/J/K/L` - Pane navigation (vim-style)
- `Ctrl-B Ctrl-{E/O/S}` - Toggle panels

## Neovim Configuration

Located in `.config/nvim/lua/custom/plugins/`:
- LSP configuration with completion
- Plugin management via vim-plug
- Custom colorscheme and UI components
- Git integration (fugitive, git signs)
- File navigation (fzf-lua, neo-tree)
- Productivity plugins (harpoon, which-key, todo-comments)

## AWS/Kubernetes Workflow

The repository includes AWS profile configurations:
- `stage-headuser` - Stage environment access
- `central-headuser` - Central account access

Use `eval $(aws-okta-py env {profile})` before kubectl commands.

## Git Security

- SSH keys are encrypted using `git-crypt` with GPG
- GPG keys are imported via bootstrap scripts
- Use `git crypt unlock` to decrypt sensitive files
- SSH key permissions are automatically set to 400 during installation
- Requires EXPORTED_GPG_ZIP environment variable pointing to GPG key archive

## VM Dependencies

The VM bootstrap installs:
- Development tools: git, make, curl, stow
- CLI utilities: bat, fzf, zoxide, eza, ripgrep, btop
- Neovim (compiled from source)
- Starship prompt
- Fish shell (set as default)

## Network Configuration

- VM uses UTM with Emulated VLAN networking mode
- SSH port forwarding: Host:2022 → Guest:22
- Connection via `ssh vm` (configured in `.ssh/config`)
- Emulated VLAN mode ensures VM traffic routes through host VPN
- Avoids connectivity issues with bridged networking mode