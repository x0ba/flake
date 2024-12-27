{pkgs, ...}:
pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    git
    git-crypt
    just
    nix-output-monitor
    nixd
    nvd
    sops
  ];
}
