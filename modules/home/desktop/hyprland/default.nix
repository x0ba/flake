{
  lib,
  config,
  namespace,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.${namespace}.desktop.hyprland;
in {
  options.${namespace}.desktop.hyprland = {
    enable = mkEnableOption "hyprland";
  };

  config = mkIf cfg.enable {
    skibidi.desktop.addons = {
      waybar.enable = true;
      wofi.enable = true;
      mako.enable = true;
      gtklock.enable = true;
      wlogout.enable = true;
    };

    wayland.windowManager.hyprland = {
      enable = true;
      package = null;
    };

    home.packages = with pkgs; [
      grim
      slurp
      wayfreeze
      swappy
      imagemagick
      killall

      (writeShellScriptBin "screenshot" ''
        killall wayfreeze
        killall grim
        killall slurp
        sleep .1
        wayfreeze & PID=$!; sleep .1; grim -g "$(slurp)" - | convert - -shave 1x1 PNG:- | wl-copy; kill $PID
      '')
      (writeShellScriptBin "screenshot-edit" ''
        wl-paste | swappy -f -
      '')
    ];
    home.configFile = {
      "hypr/launch".source = ./launch;
      "hypr/hyprland.conf".source = ./hyprland.conf;
      "hypr/colors.conf" = {
        text = ''
          general {
            col.active_border = 0xff94e2d5 0xff89b4fa 270deg
            col.inactive_border = 0xff1e1e2e
          }
        '';
      };
    };
  };
}
