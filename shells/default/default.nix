{pkgs, ...}:
pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    git
    git-crypt
    alejandra
    just
    nix-output-monitor
    nixd
    nvd
  ];
}
