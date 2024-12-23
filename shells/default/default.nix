{pkgs, ...}:
pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    treefmt
    git
    home-manager

    alejandra
    python310Packages.mdformat
    shfmt
  ];
}
