{
  description = "x0ba's hm flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };  
    nur.url = "github:nix-community/nur";
    snowfall-lib = {
      url = "github:snowfallorg/lib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.flake-compat.follows = "";
      inputs.flake-utils.follows = "flake-utils";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ghostty = {
      url = "git+ssh://git@github.com/ghostty-org/ghostty";
      inputs.nixpkgs-stable.follows = "nixpkgs";
      inputs.nixpkgs-unstable.follows = "nixpkgs";
    };
    ghostty-hm.url = "github:clo4/ghostty-hm-module";
  };

  outputs = inputs:
    inputs.snowfall-lib.mkFlake {
      inherit inputs;
      src = ./.;

      snowfall = {
        namespace = "skibidi";

        meta = {
          name = "skibidi-flake";
          title = "Skibidi Flake";
        };
      };

      homes.modules = with inputs; [
        ghostty-hm.homeModules.default
      ];

      overlays = with inputs; 
        [
          inputs.nix-vscode-extensions.overlays.default
          (
            final: prev:
            let
              inherit (final.stdenv) system;
            in
            {
              nur = import inputs.nur {
                nurpkgs = final;
                pkgs = final;
              };
            }
          )
        ];
    };
}
