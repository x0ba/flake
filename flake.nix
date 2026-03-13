{
  description = "daniel's flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.noctalia-qs.follows = "noctalia-qs";
    };

    noctalia-qs = {
      url = "github:noctalia-dev/noctalia-qs";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    nix-vscode-extensions.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      nix-darwin,
      home-manager,
      ...
    }:
    let
      inherit (nixpkgs) lib;

      user = "daniel";
      systems = [
        "aarch64-darwin"
        "x86_64-linux"
      ];

      forAllSystems = lib.genAttrs systems;

      mkPkgs =
        system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };

      mkDevShell =
        system:
        let
          pkgs = mkPkgs system;
        in
        pkgs.mkShell {
          packages = [
            pkgs.cachix
            pkgs.deadnix
            pkgs.git
            pkgs.home-manager
            pkgs.just
            pkgs.jq
            pkgs.nil
            pkgs.nix-output-monitor
            pkgs.nix-tree
            pkgs.nixfmt
            pkgs.statix
          ]
          ++ lib.optionals pkgs.stdenv.isDarwin [
            nix-darwin.packages.${system}.darwin-rebuild
          ];
        };

      mkHome =
        {
          system,
          hostName,
          modules,
        }:
        home-manager.lib.homeManagerConfiguration {
          pkgs = mkPkgs system;
          extraSpecialArgs = {
            inherit
              inputs
              self
              user
              hostName
              ;
          };
          modules = modules;
        };
    in
    {
      formatter = forAllSystems (system: (mkPkgs system).nixfmt);
      devShells = forAllSystems (system: {
        default = mkDevShell system;
      });

      darwinConfigurations.macbook-air = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs = {
          inherit inputs self user;
          hostName = "macbook-air";
        };
        modules = [
          ./modules/nix-core.nix
          home-manager.darwinModules.home-manager
          ./hosts/macbook-air
        ];
      };

      nixosConfigurations.thinkpad = lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs self user;
          hostName = "thinkpad";
        };
        modules = [
          ./modules/nix-core.nix
          inputs.niri.nixosModules.niri
          home-manager.nixosModules.home-manager
          ./hosts/thinkpad
        ];
      };

      homeConfigurations."${user}@macbook-air" = mkHome {
        system = "aarch64-darwin";
        hostName = "macbook-air";
        modules = [ ./home/darwin ];
      };

      homeConfigurations."${user}@thinkpad" = mkHome {
        system = "x86_64-linux";
        hostName = "thinkpad";
        modules = [
          inputs.niri.homeModules.config
          ./home/linux
        ];
      };
    };
}
