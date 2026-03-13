[private]
@default:
  just --choose

nix_options := (
  '--flake . ' +
  '--option accept-flake-config true ' +
  '--option extra-experimental-features "flakes nix-command"'
)

# wrapper around {nixos,darwin}-rebuild, always taking the flake
[private]
[macos]
rebuild *args:
  sudo darwin-rebuild {{nix_options}} {{args}} |& nom

[private]
[linux]
rebuild *args:
  nixos-rebuild --ask-sudo-password {{nix_options}} {{args}} |& nom

@build *args:
  just rebuild build {{args}}
  nvd diff /run/current-system result

home *args:
  home-manager {{nix_options}} {{args}} |& nom

[linux]
@boot *args:
  just rebuild boot {{args}}

[macos]
@check *args:
  just rebuild check {{args}}

[linux]
@check *args:
  just rebuild dry-build {{args}}

@format:
  nix fmt $(rg --files -g '*.nix')

@switch *args:
  just build {{args}}
  just confirm-switch {{args}}

[confirm]
[private]
@confirm-switch *args:
  just rebuild switch {{args}}

clean:
  sudo nix-env --profile /nix/var/nix/profiles/system --delete-generations old
  nix-collect-garbage -d
  nix store optimise
