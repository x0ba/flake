# x0ba's dotfiles

[![flake check status](https://img.shields.io/github/actions/workflow/status/x0ba/dotfiles/check.yml?label=flake%20check&logo=nixos&logoColor=%23fff&style=flat-square&color=f5c2e7)](https://github.com/x0ba/dotfiles/actions/workflows/check.yml)

Here are my cross-platform dotfiles using NixOS, home-manager, and nix-darwin.

# Overview

- Terminal: Ghostty
- Shell: zsh + starship prompt
- Browser: Firefox
- Editor: Neovim
- Other random bits of config tools I've collected over the years
- Window Manager (Linux only): niri

# Installation

Feel free to copy bits and pieces from these configs, but I do not recommend installing the whole thing on your machine.
These notes are purely for my own reference.

## NixOS

Install NixOS with the Calamares installer, with encrypted disk. Copy `hardware-config.nix` to the proper folder in `systems`, then clone this repo, `cd` into it and run `just switch`.

## MacOS

Install the XCode command line tools using `sudo xcode select --install`
Install Homebrew: `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`.
Install Nix using `curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install`.
Clone these dots and run `just switch`.
