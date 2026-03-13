{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.app.nautilus;
in
{
  options.app.nautilus.enable = lib.mkEnableOption "Nautilus";

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.nautilus ];

    xdg.mimeApps.defaultApplications."inode/directory" = [ "org.gnome.Nautilus.desktop" ];
  };
}
