{
  lib,
  config,
  pkgs,
  namespace,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.${namespace}.desktop.gtk;
in
{
  options.${namespace}.desktop.gtk = {
    enable = mkEnableOption "gtk";
  };

  config = mkIf cfg.enable {
    home.pointerCursor = {
      name = "phinger-cursors-light";
      package = pkgs.phinger-cursors;
      gtk.enable = true;
    };

    dconf.settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
      "org/gnome/desktop/interface" = {
        text-scaling-factor = 1.25;
      };
    };

    qt = {
      enable = true;
      platformTheme.name = "gtk3";
    };

    gtk = {
      enable = true;
      font.name = "Inter";
      iconTheme = {
        name = "Yaru-dark";
        package = pkgs.yaru-theme;
      };
      theme = {
        name = "Yaru-Dark";
        package = pkgs.yaru-theme;
      };
    };
  };
}
