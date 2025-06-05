# Aincrad - My Dotfiles

This repository contains my system configurations for a Linux (Ubuntu) virtual machine running on Apple Silicon Mac. I use this setup for development, keeping MacOS as my primary OS while utilizing Linux for development tasks.

## My MacOS Subsystem for Linux 😉

I prefer MacOS for everyday applications and Apple's hardware ecosystem, but I find Linux more suitable for development work. This setup gives me the best of both worlds:

### Host-Guest Architecture
- **Host OS**: MacOS on Apple Silicon
- **Virtualization**: [UTM](https://mac.getutm.app/) (QEMU-based VM manager for Mac)
- **Guest OS**: Ubuntu ARM Server

### Development Environment
- **Code Editor**: Run Neovim and Tmux inside the VM after SSH
- **Terminal**: Ghostty
- **Window Management**: Aerospace tiling window manager

![neovim](./docs/neovim.png)

![tmux](./docs/tmux.png)

![vm](./docs/vm.png)

### Network Connectivity 🔗

**Drawbacks of default bridged network**
- Doesn't work properly with VPN on host - VM traffic bypasses the VPN
- Can have connectivity issues when host network configuration changes
- May expose VM directly to potentially unsecure networks

**Using Emulated VLAN with SSH Port Forwarding**
1. In UTM, set VM network to "Emulated VLAN"

![UTM Network](./docs/utm-network.png)

2. Configure port forwarding: Host port 2022 → Guest port 22

![UTM Port Forwarding](./docs/utm-port-forwarding.png)

3. Connect via `ssh vm` using the following SSH config. See [SSH Configuration](.ssh/config) for details.

```ssh
Host vm
  HostName 127.0.0.1
  Port 2022
  User msharran
  IdentityFile ~/.ssh/id_msharran
  IdentitiesOnly yes
```

This was suggested by the community in the UTM GitHub issue as a workaround for VPN issues:

> Have you tried the emulated VLAN network mode? If any, that one would definitely go through the VPN since it's emulated in userspace. The other modes use macOS Virtualization features that might not respect the host's VPN settings.
> https://github.com/utmapp/UTM/issues/3238#issuecomment-959911107

### Development Workflow 🛠️

I use Ghostty MacOS application, then SSH into the VM and run
tmux and neovim for development tasks.

For rest of the tasks, I use MacOS applications like Aerospace for window management, Chrome for browsing etc.,

---

## Productivity Tasks: Fast Project/Window Switching

### tmux-sessioniser (Terminal/Neovim)
If you're working in the terminal (with tmux), launch `tmux-sessioniser` (aliased as `t`) to quickly search and switch tmux sessions/projects with [fzf](https://github.com/junegunn/fzf).
This script enumerates major directories, lets you fuzzy-pick one, and attaches (or creates) a tmux session for it in a single step.

Example usage:
```bash
t              # fuzzy find and jump to a project in tmux
t ~/some/dir   # jump directly if path is provided
```
_Source: [sbin/tmux-sessioniser](sbin/tmux-sessioniser)_

---

### fzf-zed Task (Zed Editor)
Zed doesn't natively have a quick session/project switcher like tmux—so I created a similar solution using a Zed task and fzf!

- **Task Name:** `fzf-zed`
- **How to run:** Hit <kbd>Ctrl-S</kbd> (when in workspace view) to launch the task.
- **Behavior:** This spawns your custom `fzf-zed` shell command, letting you search/open projects or Zed windows in a lightning-fast way, just like the terminal workflow above but inside Zed.
- **Key binding:** Configured in [.config/zed/keymap.json](.config/zed/keymap.json).
- **Task config:** See [.config/zed/tasks.json](.config/zed/tasks.json).
- **Benefit:** Makes switching between project windows in Zed almost as fast as with tmux, supercharging multi-project development without ever leaving the keyboard.
- **Screenshot / Confirmation:**
  ![Zed fzf task](./docs/zed-fzf-task.png)

If you want to adapt the core of `tmux-sessioniser` for Zed or customize project filtering, just edit your Zed `fzf-zed` script (refer to your shell scripts or automate as needed).

---

> *Note: My host git projects are primarily dotfiles*

## Usage Instructions

Run the following in Host's `$HOME` directory.

> Note: My SSH keys are encrypted by `git-crypt` using my GPG key.
   
```bash
# Path to my GPG keys
export EXPORTED_GPG_ZIP=~/Downloads/sharran-gpg-20250316T104202Z-001.zip

# Clone Aincrad
git clone https://github.com/msharran/aincrad.git
cd aincrad

# Bootstrap HostOS
make host/bootstrap

# Bootstrap GuestOS
make vm/bootstrap
```

This setup is inspired by [Mitchell's NixOS setup on Mac](https://x.com/mitchellh/status/1346136404682625024?s=46) and [Liz's Linux VMs article](https://medium.com/@lizrice/linux-vms-on-an-m1-based-mac-with-vscode-and-utm-d73e7cb06133).
