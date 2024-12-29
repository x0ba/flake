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
      wl-clipboard
      # thumbnails
      webp-pixbuf-loader
      ffmpegthumbnailer
    ];
    programs.file-roller.enable = true;

    programs.nautilus-open-any-terminal = {
      enable = true;
      terminal = "ghostty";
    };

    environment.sessionVariables.NAUTILUS_4_EXTENSION_DIR = "${pkgs.nautilus-python}/lib/nautilus/extensions-4";
    environment.pathsToLink = [
      "/share/nautilus-python/extensions"
    ];

    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gnome
      ];
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
