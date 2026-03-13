# nix-config

Flake-based multi-host Nix configuration for:

- `macbook-air`: `aarch64-darwin` with `nix-darwin`, Home Manager, and declarative Homebrew for macOS apps.
- `thinkpad`: `x86_64-linux` with NixOS, Home Manager, and a minimal Niri desktop stack.

## Layout

- `flake.nix`: inputs and host outputs.
- `hosts/`: system-level darwin and NixOS modules.
- `home/`: shared Home Manager modules plus host-specific config payloads.
- `nix develop`: enters a repo dev shell with formatting, linting, and flake-management tools.
- `format`: available inside `nix develop`; formats all tracked `*.nix` files by passing them explicitly to `nix fmt`.
- `check`: available inside `nix develop`; runs `nix flake check`.

## Bootstrap

### macOS

1. Install Nix with flakes enabled.
2. Enter `nix develop` if you want the repo toolchain in-shell.
3. From this repo, run `nix develop -c format` and `nix develop -c check`.
4. Apply the darwin host with `darwin-rebuild switch --flake .#macbook-air`.

### ThinkPad

1. Copy this repo onto the ThinkPad.
2. Replace `hosts/thinkpad/hardware-configuration.nix` with the machine-generated file from `nixos-generate-config`.
3. Enter `nix develop` if you want the repo toolchain in-shell.
4. Run `nix develop -c format` and `nix develop -c check`.
5. Apply the system with `sudo nixos-rebuild switch --flake .#thinkpad`.

## Notes

- Shared Nix settings enable the public `nix-community` Cachix cache in [modules/nix-core.nix](/Users/daniel/nix-config/modules/nix-core.nix) on NixOS. The Mac host has `nix.enable = false` to stay compatible with Determinate Nix, so Nix installation settings are not managed there by `nix-darwin`.
- Secret-bearing files were intentionally left out of declarative management: `~/.wakatime.cfg`, `~/.claude.json`, `~/.config/gh/hosts.yml`, `~/.config/raycast/config.json`, `~/.ssh`, `~/.gnupg`, and other cache/state directories.
- `homebrew.brews` is intentionally small. Most CLI tools were translated into Nix packages; the built-in `nix-darwin` Homebrew module remains for macOS GUI apps and the few unsupported formulae.
- The ThinkPad hardware file is a placeholder and must be replaced before first real deployment.
