{
  options,
  config,
  pkgs,
  lib,
  inputs,
  namespace,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.desktop.sway;
in
{
  options.${namespace}.desktop.sway = with types; {
    enable = mkBoolOpt false "Enable or disable the sway window manager.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      # file management
      nautilus
      nautilus-python
      nautilus-open-any-terminal
      # thumbnails
      webp-pixbuf-loader
      ffmpegthumbnailer
    ];
    programs.dconf.enable = true;

    environment.pathsToLink = [ "/share/nautilus-python/extensions" ];
    environment.sessionVariables.NAUTILUS_4_EXTENSION_DIR = "/var/run/current-system/sw/lib/nautilus/extensions-4";

    programs.file-roller.enable = true;
    programs.sway = {
      enable = true;
      package = pkgs.swayfx;
      extraSessionCommands =
        # bash
        ''
          # session
          export XDG_SESSION_TYPE=wayland
          export XDG_SESSION_DESKTOP=sway
          export XDG_CURRENT_DESKTOP=sway
          # wayland
          export NIXOS_OZONE_WL=1
          export MOZ_ENABLE_WAYLAND=1
          export QT_QPA_PLATFORM=wayland
          export SDL_VIDEODRIVER=wayland
          export _JAVA_AWT_WM_NONREPARENTING=1
        '';
      wrapperFeatures = {
        base = true;
        gtk = true;
      };
    };

    services.dbus.packages = with pkgs; [
      nautilus-open-any-terminal
    ];

    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
      ];
      wlr.enable = true;
      xdgOpenUsePortal = true;
    };

    services = {
      # mounting
      gvfs.enable = true;
      udisks2.enable = true;
      devmon.enable = true;
      # previews
      gnome.sushi.enable = true;
      # search metadata
      gnome.tracker-miners.enable = true;
      # thumbnails
      tumbler.enable = true;
    };
  };
}
