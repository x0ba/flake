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
  cfg = config.${namespace}.desktop.niri;
in {
  options.${namespace}.desktop.niri = with types; {
    enable = mkBoolOpt false "Enable or disable the niri window manager.";
  };

  config = mkIf cfg.enable {
    security.pam.services.swaylock = {};

    programs.niri.enable = true;
    programs.dconf.enable = true;
    skibidi.desktop.greeter.enable = true;

    environment.systemPackages = with pkgs; [
      # file management
      nautilus
      nautilus-python
      nautilus-open-any-terminal
      wl-clipboard
      # thumbnails
      webp-pixbuf-loader
      ffmpegthumbnailer
    ];
    programs.file-roller.enable = true;

    environment.pathsToLink = ["/share/nautilus-python/extensions"];
    environment.sessionVariables.NAUTILUS_4_EXTENSION_DIR = "/var/run/current-system/sw/lib/nautilus/extensions-4";

    services.dbus.packages = with pkgs; [
      nautilus-open-any-terminal
    ];

    services = {
      # mounting
      gvfs.enable = true;
      udisks2.enable = true;
      devmon.enable = true;
      # previews
      gnome = {
        sushi.enable = true;
        gnome-keyring.enable = true;
      };
      # search metadata
      gnome.tracker-miners.enable = true;
      # thumbnails
      tumbler.enable = true;
    };
  };
}
