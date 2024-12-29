# x0ba's dotfiles

[![flake check status](https://img.shields.io/github/actions/workflow/status/x0ba/dotfiles/check.yml?label=flake%20check&logo=nixos&logoColor=%23fff&style=flat-square&color=f5c2e7)](https://github.com/x0ba/dotfiles/actions/workflows/check.yml)

Here are my cross-platform dotfiles using NixOS, home-manager, and nix-darwin.

# Overview

- Terminal: Ghostty
- Shell: zsh + starship prompt
- Browser: Firefox
- Editor: Neovim
- Other random bits of config tools I've collected over the years
- Window Manager (Linux only): niri + waybar

# Installation

## NixOS

1. Acquire a NixOS 24.05+ image:

```bash
wget -O https://channels.nixos.org/nixos-24.11/latest-nixos-minimal-x86_64-linux.iso
```

2. Write it to a USB drive. I prefer [Ventoy](https://www.ventoy.net/).
3. Restart and boot into the installer.
4. Clone these dotfiles somewhere and `cd` into them.
```bash
git clone https://github.com/x0ba/dotfiles.git
```
5. Set your desired encryption password.
```bash
echo -n "password" > /tmp/secret.key
```
6. Partition your disks using [disko](https://github.com/nix-community/disko). Make sure to replace the device arg with the hard disk you want to install NixOS on.
```bash
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --arg device '"/dev/nvme0n1"' --mode destroy,format,mount ./disks/default.nix
```
7. Create a host config in `systems`. See existing ones for examples.
8. Install NixOS
```bash
sudo nixos-install --root /mnt --flake .#host
```
9. Reboot and you're good to go!
10. [OPTIONAL] Set up an SSH key to decrypt sops secrets. Currently it's only being used to declaratively set my user password and for tailscale.

## Darwin

1. Install the XCode command line tools
```bash
sudo xcode-select --install
```
2. Install Homebrew.
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```
3. Install Nix using the [Determinate installer](https://github.com/DeterminateSystems/nix-installer).
```bash
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | \
  sh -s -- install
```
