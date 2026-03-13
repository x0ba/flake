{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.app.evince;
in
{
  options.app.evince.enable = lib.mkEnableOption "Evince";

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.evince ];

    xdg.mimeApps.defaultApplications."application/pdf" = [ "org.gnome.Evince.desktop" ];
  };
}
