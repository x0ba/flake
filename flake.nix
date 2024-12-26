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
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-cosmic = {
      url = "github:lilyinstarlight/nixos-cosmic";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs:
    inputs.snowfall-lib.mkFlake {
      inherit inputs;
      src = ./.;

      channels-config = {
        allowUnfree = true;
      };

      snowfall = {
        namespace = "skibidi";

        meta = {
          name = "skibidi-flake";
          title = "Skibidi Flake";
        };
      };

      homes.modules = with inputs; [
        ghostty-hm.homeModules.default
        nix-index-database.hmModules.nix-index
        niri.homeModules.niri
      ];

      systems.modules.nixos = with inputs; [
        nixos-cosmic.nixosModules.default
        home-manager.nixosModules.home-manager
      ];

      outputs-builder =
        channels:
        let
          treefmtConfig =
            { ... }:
            {
              projectRootFile = "flake.nix";
              programs = {
                nixfmt-rfc-style.enable = true;
                mdformat.enable = true;
                deadnix.enable = true;
                just.enable = true;
                stylua.enable = true;
              };
            };
          treefmtEval = inputs.treefmt-nix.lib.evalModule (channels.nixpkgs) treefmtConfig;
        in
        {
          formatter = treefmtEval.config.build.wrapper;
        };

      overlays = with inputs; [
        inputs.nix-vscode-extensions.overlays.default
        (final: _prev: {
          nur = import inputs.nur {
            nurpkgs = final;
            pkgs = final;
          };
        })
      ];
    };
}
