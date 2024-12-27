{
  options,
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.desktop.gnome;
  primary-color = "#161321";
  secondary-color = "#161321";
  wallpaper-uri = "file://${../wallpapers/space.png}";
in {
  options.${namespace}.desktop.gnome = with types; {
    enable = mkBoolOpt false "Whether or not to enable gnome.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs.gnomeExtensions; [
      appindicator
      blur-my-shell
      hot-edge
      caffeine
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
        xkb-options = ["caps:ctrl_modifier"];
      };
      "org/gnome/desktop/interface" = {
        text-scaling-factor = 1.25;
        font-name = "Inter 11";
        document-font-name = "Inter 11";
        monospace-font-name = "Rec Mono Duotone 10";
        clock-show-weekday = true;
        clock-format = "12h";
      };

      # rice
      "org/gnome/shell" = {
        disable-user-extensions = false;
        enabled-extensions = [
          "appindicatorsupport@rgcjonas.gmail.com"
          "blur-my-shell@aunetx"
          "hotedge@jonathan.jdoda.ca"
          "AlphabeticalAppGrid@stuarthayhurst"
          "caffeine@patapon.info"
          "gsconnect@andyholmes.github.io"
        ];
        favorite-apps = [
          "org.gnome.Nautilus.desktop"
          "firefox.desktop"
          "com.mitchellh.ghostty.desktop"
          "thunderbird.desktop"
          "obsidian.desktop"
          "discord.desktop"
        ];
      };

      "org/gnome/settings-daemon/plugins/media-keys" = {
        custom-keybindings = [
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
        ];
      };

      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
        binding = "<Control><Alt>t";
        command = "ghostty";
        name = "ghostty";
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
    xdg.configFile = {
      "autostart/Nextcloud.desktop".text = ''
        [Desktop Entry]
        Name=Nextcloud
        GenericName=File Synchronizer
        Exec=nextcloud --background
        Terminal=false
        Icon=Nextcloud
        Categories=Network
        Type=Application
        StartupNotify=false
        X-GNOME-Autostart-enabled=true
        X-GNOME-Autostart-Delay=10
      '';
    };
  };
}
