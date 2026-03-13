# Installation Guide

This repository defines two hosts:

- `macbook-air` for macOS via `nix-darwin`
- `thinkpad` for NixOS on Linux

It also assumes the primary user is `daniel`. If the target machine should use a different username or hostname, update [flake.nix](/Users/daniel/nix-config/flake.nix), [hosts/macbook-air/default.nix](/Users/daniel/nix-config/hosts/macbook-air/default.nix), and [hosts/thinkpad/default.nix](/Users/daniel/nix-config/hosts/thinkpad/default.nix) before you apply the configuration.

## Prerequisites

- A clone of this repo on the target machine
- Internet access during the initial install
- Comfort with replacing the target machine's current system configuration

Recommended first check from the repo root:

```sh
nix develop -c format
nix develop -c check
```

## macOS

This host is configured as `macbook-air` and expects Apple Silicon (`aarch64-darwin`).

### 1. Install Nix

This repo sets `nix.enable = false` on macOS, so install Nix separately first. Determinate Nix is the cleanest fit:

```sh
curl --proto '=https' --tlsv1.2 -sSfL https://install.determinate.systems/nix | sh -s -- install
```

Open a fresh shell after the installer finishes.

### 2. Clone the repo

```sh
git clone <your-repo-url> ~/nix-config
cd ~/nix-config
```

### 3. Validate the flake

```sh
nix develop -c format
nix develop -c check
```

### 4. Apply the macOS configuration

Use the repo dev shell so you do not need a preinstalled `darwin-rebuild`:

```sh
nix develop -c darwin-rebuild switch --flake .#macbook-air
```

### 5. Verify

Check that the system applied and Home Manager activated:

```sh
darwin-rebuild --version
home-manager generations | head
```

## Linux

This host is configured as `thinkpad` and expects `x86_64-linux`.

The steps below assume:

- a 512 GB SSD
- UEFI boot
- the disk is `/dev/nvme0n1`
- you want a simple layout with EFI, swap, and one ext4 root partition

Confirm the disk name before running any partitioning command:

```sh
lsblk -o NAME,SIZE,TYPE,MODEL
```

### Partition layout

For a 512 GB SSD, this guide uses:

- `512 MiB` EFI system partition
- `8 GiB` swap partition
- remaining space for `/`

That is a practical default for a ThinkPad with suspend support and modest swap headroom without wasting too much disk.

### 1. Boot the NixOS installer

Boot the official NixOS installer in UEFI mode and open a shell.

### 2. Partition the SSD

This destroys the current contents of `/dev/nvme0n1`.

```sh
parted /dev/nvme0n1 -- mklabel gpt
parted /dev/nvme0n1 -- mkpart ESP fat32 1MiB 513MiB
parted /dev/nvme0n1 -- set 1 esp on
parted /dev/nvme0n1 -- mkpart primary linux-swap 513MiB 8705MiB
parted /dev/nvme0n1 -- mkpart primary ext4 8705MiB 100%
```

Resulting partitions:

- `/dev/nvme0n1p1` -> EFI
- `/dev/nvme0n1p2` -> swap
- `/dev/nvme0n1p3` -> root

### 3. Format the partitions

```sh
mkfs.fat -F 32 -n boot /dev/nvme0n1p1
mkswap -L swap /dev/nvme0n1p2
mkfs.ext4 -L nixos /dev/nvme0n1p3
```

### 4. Mount the target filesystem

```sh
mount /dev/disk/by-label/nixos /mnt
mkdir -p /mnt/boot
mount /dev/disk/by-label/boot /mnt/boot
swapon /dev/disk/by-label/swap
```

### 5. Generate hardware config

```sh
nixos-generate-config --root /mnt
```

The generated file should include the mounted filesystems. Verify swap is present in `/mnt/etc/nixos/hardware-configuration.nix`. If it is missing, add:

```nix
swapDevices = [
  { device = "/dev/disk/by-label/swap"; }
];
```

### 6. Copy this repo onto the target system

If the repo is on GitHub:

```sh
git clone <your-repo-url> /mnt/home/daniel/nix-config
```

If you already have a local checkout somewhere else, copy it into `/mnt/home/daniel/nix-config`.

### 7. Replace the placeholder hardware config

Overwrite the repo placeholder with the generated machine-specific file:

```sh
cp /mnt/etc/nixos/hardware-configuration.nix /mnt/home/daniel/nix-config/hosts/thinkpad/hardware-configuration.nix
```

Then make sure the copied file still includes:

```nix
fileSystems."/" = {
  device = "/dev/disk/by-label/nixos";
  fsType = "ext4";
};

fileSystems."/boot" = {
  device = "/dev/disk/by-label/boot";
  fsType = "vfat";
};

swapDevices = [
  { device = "/dev/disk/by-label/swap"; }
];
```

### 8. Validate the flake from the repo

```sh
cd /mnt/home/daniel/nix-config
nix develop -c format
nix develop -c check
```

### 9. Install and switch to the host configuration

Install NixOS with the flake:

```sh
nixos-install --flake .#thinkpad
```

After rebooting into the installed system:

```sh
cd ~/nix-config
sudo nixos-rebuild switch --flake .#thinkpad
```

## Post-install notes

- Secrets and machine-local state are intentionally not managed here. Recreate items such as `~/.ssh`, `~/.gnupg`, `~/.config/gh/hosts.yml`, and similar files manually.
- On macOS, Homebrew apps are managed through `nix-darwin` after the first successful apply.
- On Linux, this repo enables `systemd-boot`, NetworkManager, PipeWire, `greetd`, and the Niri session defined in [hosts/thinkpad/default.nix](/Users/daniel/nix-config/hosts/thinkpad/default.nix).
