{pkgs, ...}:
pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    git
    alejandra
    just
    nix-output-monitor
    nixd
    nvd
  ];
}
