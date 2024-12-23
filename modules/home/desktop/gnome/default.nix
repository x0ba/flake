inputs@{
  options,
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.desktop.gnome;
  primary-color = "#161321";
  secondary-color = "#161321";
  wallpaper-uri = "file://${../../../../assets/house.png}";
in
{
  options.${namespace}.desktop.gnome = with types; {
    enable = mkBoolOpt false "Whether or not to enable gnome.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs.gnomeExtensions; [
      appindicator
      blur-my-shell
      hot-edge
      alphabetical-app-grid
    ];
    dconf.settings = with lib.gvariant; {
      # input
      "org/gnome/desktop/wm/preferences" = {
        resize-with-right-button = true;
      };
      "org/gnome/mutter" = {
        dynamic-workspaces = true;
	edge-tiling = true;
      };
      "org/gnome/desktop/input-sources" = {
        sources = [
          (mkTuple [
            "xkb"
            "us"
          ])
        ];
        xkb-options = [ "caps:ctrl_modifier" ];
      };
      "org/gnome/desktop/interface" = {
        text-scaling-factor = 1.25;
      };

      # rice
      "org/gnome/shell" = {
        disable-user-extensions = false;
        enabled-extensions = [
          "appindicatorsupport@rgcjonas.gmail.com"
          "blur-my-shell@aunetx"
	  "hotedge@jonathan.jdoda.ca"
	  "AlphabeticalAppGrid@stuarthayhurst"
        ];
        favorite-apps = [
          "org.gnome.Nautilus.desktop"
          "firefox.desktop"
          "com.mitchellh.ghostty.desktop"
        ];
      };

      # wallpaper
      "org/gnome/desktop/background" = {
        color-shading-type = "solid";
        picture-options = "zoom";
        picture-uri = wallpaper-uri;
        picture-uri-dark = wallpaper-uri;
        inherit primary-color secondary-color;
      };
      "org/gnome/desktop/screensaver" = {
        color-shading-type = "solid";
        picture-options = "zoom";
        picture-uri = wallpaper-uri;
        inherit primary-color secondary-color;
      };
    };
  };
}
