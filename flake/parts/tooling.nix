{ inputs, self, ... }:
let
  inherit (inputs.nixpkgs) lib;
in
{
  perSystem =
    { pkgs, self', ... }:
    {
      formatter = pkgs.nixfmt;

      devShells.default = pkgs.mkShell {
        packages =
          with pkgs;
          [
            cachix
            deadnix
            git
            home-manager
            just
            jq
            nil
            nix-output-monitor
            nix-tree
            nixfmt
            statix
            nvd
          ]
          ++ lib.optionals pkgs.stdenv.isDarwin [
            inputs.nix-darwin.packages.${pkgs.stdenv.hostPlatform.system}.darwin-rebuild
          ];
      };
    };
}
