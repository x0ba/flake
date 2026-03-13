{
  description = "Daniel Xu's multi-host Nix configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
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

          shellHook = ''
            echo "nix-config dev shell (${system})"
            echo "Common commands: ./format, ./check"
            echo "Home Manager apply: home-manager switch --flake .#${user}@$(hostname -s 2>/dev/null || hostname)"
          ''
          + lib.optionalString pkgs.stdenv.isDarwin ''
            echo "Darwin apply: darwin-rebuild switch --flake .#macbook-air"
          ''
          + lib.optionalString pkgs.stdenv.isLinux ''
            echo "NixOS apply: sudo nixos-rebuild switch --flake .#thinkpad"
          '';
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
        modules = [ ./home/linux ];
      };
    };
}
