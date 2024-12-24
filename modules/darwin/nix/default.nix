{
  options,
  config,
  pkgs,
  lib,
  namespace,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.nix;
in {
  options.${namespace}.nix = with types; {
    enable = mkBoolOpt true "Whether or not to manage nix configuration.";
    package = mkOpt package pkgs.lix "Which nix package to use.";
  };

  config = mkIf cfg.enable {
    nixpkgs = {
      config.allowUnfree = true;
    };

    nix = let
      users = [
        "@sudo"
        "@wheel"
        "daniel"
        "d"
      ];
    in {
      package = cfg.package;

      settings = {
        experimental-features = [
          "auto-allocate-uids"
          "flakes"
          "nix-command"
        ];
        http-connections = 50;
        use-xdg-base-directories = true;
        warn-dirty = false;
        log-lines = 50;
        sandbox = "relaxed";
        trusted-users = users;
        allowed-users = users;

        substituters = [
          "https://nix-community.cachix.org"
          "https://cosmic.cachix.org"
          "https://pre-commit-hooks.cachix.org"
          "https://mic92.cachix.org"
        ];
        trusted-public-keys = [
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
          "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="
          "pre-commit-hooks.cachix.org-1:Pkk3Panw5AW24TOv6kz3PvLhlH8puAsJTBbOPmBo7Rc="
          "mic92.cachix.org-1:gi8IhgiT3CYZnJsaW7fxznzTkMUOn1RY4GmXdT/nXYQ="
        ];
      };

      gc = {
        automatic = true;
        interval = {
          Weekday = 0;
          Hour = 0;
          Minute = 0;
        };
      };

      # flake-utils-plus
      generateRegistryFromInputs = true;
      generateNixPathFromInputs = true;
      linkInputs = true;
    };
  };
}
