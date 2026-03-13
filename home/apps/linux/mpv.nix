{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.app.mpv;
in
{
  options.app.mpv.enable = lib.mkEnableOption "mpv";

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.mpv ];

    xdg.mimeApps.defaultApplications."video/mp4" = [ "mpv.desktop" ];
  };
}
