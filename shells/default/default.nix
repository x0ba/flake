{
  pkgs,
  inputs,
  lib,
  ...
}:
pkgs.mkShellNoCC {
  buildInputs = with pkgs;
    [
      git
      git-crypt
      just
      nix-output-monitor
      nixd
      nvd
      sops
    ]
    ++ lib.optionals pkgs.stdenv.isDarwin [inputs.darwin.packages.darwin-rebuild];
}
