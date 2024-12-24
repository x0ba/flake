{
  lib,
  config,
  pkgs,
  namespace,
  ...
}: let
  inherit (pkgs.stdenv) isLinux;
  inherit (lib) mkEnableOption mkIf;

  cfg = config.${namespace}.desktop.gtk;
in {
  options.${namespace}.desktop.gtk = {
    enable = mkEnableOption "gtk";
  };

  config = mkIf cfg.enable {
    home.pointerCursor = {
      name = "phinger-cursors-light";
      package = pkgs.phinger-cursors;
      gtk.enable = true;
    };

    gtk = {
      enable = true;
      font.name = "Inter";
      iconTheme = {
        name = "Yaru-dark";
        package = pkgs.yaru-theme;
      };
      theme = {
        name = "Yaru-dark";
        package = pkgs.yaru-theme;
      };
    };
  };
}
