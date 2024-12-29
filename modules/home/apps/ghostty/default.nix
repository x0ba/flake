{
  lib,
  config,
  pkgs,
  namespace,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  inherit (pkgs.stdenv.hostPlatform) isLinux;

  cfg = config.${namespace}.apps.ghostty;
in {
  options.${namespace}.apps.ghostty = {
    enable = mkEnableOption "ghostty";
  };

  config = mkIf cfg.enable {
    home.packages = lib.mkIf isLinux [
      pkgs.ghostty
    ];
    programs.ghostty = {
      enable = true;
      settings = {
        font-size = 13;
        font-family = "BerkeleyMono Nerd Font";

        theme = "catppuccin-mocha";

        window-padding-x = "7";
        window-padding-y = "7";
      };
    };
  };
}
