{
  lib,
  config,
  pkgs,
  inputs,
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
      inputs.ghostty.packages.x86_64-linux.default
    ];
    programs.ghostty = {
      enable = true;
      settings = {
        font-size = 13;
        font-family = "BerkeleyMono Nerd Font";

        theme = "catppuccin-mocha";
        confirm-close-surface = false;

        gtk-single-instance = true;

        window-padding-x = "7";
        window-padding-y = "7";
      };
    };
  };
}
