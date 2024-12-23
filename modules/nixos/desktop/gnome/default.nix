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

  defaultExtensions = with pkgs.gnomeExtensions; [
    appindicator
  ];

  default-attrs = mapAttrs (key: mkDefault);
  nested-default-attrs = mapAttrs (key: default-attrs);
in {
  options.${namespace}.desktop.gnome = with types; {
    enable = mkBoolOpt false "Whether or not to use Gnome as the desktop environment.";
    wayland = mkBoolOpt true "Whether or not to use Wayland.";
    suspend = mkBoolOpt true "Whether or not to suspend the machine after inactivity.";
  };

  config = mkIf cfg.enable {
    skibidi.system.xkb.enable = true;

    services.xserver = {
      enable = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };

    environment.systemPackages = with pkgs;
      [
        wl-clipboard
        gnome-tweaks
        nautilus-python
      ]
      ++ defaultExtensions;

    environment.gnome.excludePackages = with pkgs.gnome; [
      pkgs.gnome-tour
      pkgs.epiphany
      pkgs.geary
      pkgs.gnome-font-viewer
      pkgs.gnome-system-monitor
      pkgs.gnome-maps
    ];
  };
}
