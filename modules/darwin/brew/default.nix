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
  cfg = config.${namespace}.brew;
  default-attrs = mapAttrs (key: mkDefault);
  nested-default-attrs = mapAttrs (key: default-attrs);
  noQuarantine = name: {
    inherit name;
    args.no_quarantine = true;
  };
  skipSha = name: {
    inherit name;
    args.require_sha = false;
  };
in {
  options.${namespace}.brew = with types; {  default-attrs = mapAttrs (key: mkDefault);
  nested-default-attrs = mapAttrs (key: default-attrs);
    enable = mkBoolOpt false "Whether or not to manage homebrew apps";
    casks = mkOpt (listOf string) [ ] "Extra casks to install";
    brews = mkOpt (listOf string) [ ] "Extra brews to install";
  };

  config = mkIf cfg.enable {
    # make brew available in PATH
    environment.systemPath = [ config.homebrew.brewPrefix ];

    homebrew = {
      enable = true;
      caskArgs.require_sha = true;
      brews = [ ] ++ cfg.brews;
      casks = [
        "proton-pass"
        "raycast"
        "discord"
        "easy-move+resize"
        "eloston-chromium"
        "iina"
        "jordanbaird-ice"
        "keka"
        "macfuse"
        "netnewswire"
        "nextcloud"
        "obsidian"
        "rectangle"
        "calibre"
        "orion"
        "syntax-highlight"
        "tor-browser"
        "yubico-yubikey-manager"
      ] ++ cfg.casks;
      onActivation = {
        autoUpdate = true;
        upgrade = true;
      };
    };
  };
}
