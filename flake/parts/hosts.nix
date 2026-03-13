{ inputs, self, ... }:
let
  inherit (inputs.nixpkgs) lib;

  user = "daniel";

  hosts = {
    macbook-air = {
      kind = "darwin";
      system = "aarch64-darwin";
      homeModule = ../../home/darwin;
      homeModules = [ ../../hosts/macbook-air/home.nix ];
      systemBuilder = inputs.nix-darwin.lib.darwinSystem;
      systemModules = [
        ../../modules/nix-core.nix
        inputs.home-manager.darwinModules.home-manager
        inputs.nix-index-database.darwinModules.nix-index
        inputs.nix-homebrew.darwinModules.nix-homebrew
        { programs.nix-index-database.comma.enable = true; }
        ../../hosts/macbook-air
      ];
    };

    thinkpad = {
      kind = "nixos";
      system = "x86_64-linux";
      homeModule = ../../home/linux;
      homeModules = [
        inputs.niri.homeModules.config
        ../../hosts/thinkpad/home.nix
      ];
      systemBuilder = lib.nixosSystem;
      systemModules = [
        ../../modules/nix-core.nix
        inputs.niri.nixosModules.niri
        inputs.nix-index-database.nixosModules.default
        inputs.home-manager.nixosModules.home-manager
        { programs.nix-index-database.comma.enable = true; }
        ../../hosts/thinkpad
      ];
    };
  };

  mkPkgs =
    system:
    import inputs.nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };

  mkHome =
    hostName: host:
    inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = mkPkgs host.system;
      extraSpecialArgs = {
        inherit
          inputs
          self
          user
          hostName
          ;
      };
      modules = host.homeModules ++ [ host.homeModule ];
    };

  mkSystem =
    hostName: host:
    host.systemBuilder {
      inherit (host) system;
      specialArgs = {
        inherit inputs self user;
        inherit hostName;
      };
      modules = host.systemModules;
    };
in
{
  flake = {
    darwinConfigurations = lib.mapAttrs' (
      hostName: host: lib.nameValuePair hostName (mkSystem hostName host)
    ) (lib.filterAttrs (_: host: host.kind == "darwin") hosts);

    nixosConfigurations = lib.mapAttrs' (
      hostName: host: lib.nameValuePair hostName (mkSystem hostName host)
    ) (lib.filterAttrs (_: host: host.kind == "nixos") hosts);

    homeConfigurations = lib.mapAttrs' (
      hostName: host: lib.nameValuePair "${user}@${hostName}" (mkHome hostName host)
    ) hosts;
  };
}
