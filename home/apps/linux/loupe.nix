{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.app.loupe;
in
{
  options.app.loupe.enable = lib.mkEnableOption "Loupe";

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.loupe ];

    xdg.mimeApps.defaultApplications = {
      "image/gif" = [ "org.gnome.Loupe.desktop" ];
      "image/jpeg" = [ "org.gnome.Loupe.desktop" ];
      "image/png" = [ "org.gnome.Loupe.desktop" ];
    };
  };
}
