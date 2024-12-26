{ pkgs, ... }:
pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    git
    git-crypt
    treefmt
    nixfmt-rfc-style
    just
    nix-output-monitor
    nixd
    nvd
  ];
}
