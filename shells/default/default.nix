{pkgs, inputs, lib, ...}:
pkgs.mkShell {
  nativeBuildInputs = (with pkgs; [
    git
    alejandra
    just
    nix-output-monitor
    nixd
    nvd
  ]);
  # ++ lib.optionals pkgs.stdenv.isDarwin [ inputs.darwin.packages.darwin-rebuild ];
}
