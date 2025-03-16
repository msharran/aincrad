# Aincrad - My Dotfiles

This repository contains system configurations for Ubuntu VM on my Apple Silicon Mac with Zed and UTM. It is inspired from [Mitchel's NixOS setup on Mac](https://x.com/mitchellh/status/1346136404682625024?s=46) and [Liz's Linux VMs on an M1-based Mac with VScode and UTM](https://medium.com/@lizrice/linux-vms-on-an-m1-based-mac-with-vscode-and-utm-d73e7cb06133)


# How I Work

## Linux as a Subsystem on MacOS
- MacOS as HostOS
- [UTM as a Virtual Machine Runtime](https://mac.getutm.app/)
- Linux (Ubuntu ARM Server) as GuestOS


## Connectivity

UTM's default bridged network allows for seamless communication between the host and guest operating systems.
This setup enables easy access to the guest system from the host and vice versa.
Just find out the Guest IP address by running the following command in the guest system:

```bash
ip -4 addr
```

Then use the IP address to connect to the guest system via SSH:

```bash
ssh <guest_ip_address>
```

I have added few other configurations to connect via a simple
`ssh vm` command. See [SSH Configuration](.ssh/config) for the SSH host configuration.

## Code Editing

- Zed as Code Editor
- Ghostty as Terminal Emulator

I use Zed's remote development feature which allows me to edit files on the guest system directly from my host system.
See [here](https://zed.dev/docs/remote-development) for more information.

I use Ghostty's quick terminal feature primarily to open my projects in new Zed window. [zed-fzf](./sbin/zed-fzf) script that
I wrote, lists down my git projects in my Host and Guest, opens them in Zed. It also opens the existing window if it exists.

> *Note: My Host git projects are mostly dotfiles*

![zed-fzf](./docs/zed-fzf.png)

# Usage

1. Export the environment variable for exported GPG files directory

```bash
export EXPORTED_GPG_ZIP=~/Downloads/sharran-gpg-20250316T104202Z-001.zip
```

2. Run the following in Host's $HOME dir after setting up SSH connection,

```bash
git clone https://github.com/msharran/aincrad.git
cd aincrad
make host/bootstrap
make vm/bootstrap
```
