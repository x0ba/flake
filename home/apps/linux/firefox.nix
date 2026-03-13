{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.app.firefox;
in
{
  options.app.firefox.enable = lib.mkEnableOption "Firefox";

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.firefox ];

    home.sessionVariables = {
      BROWSER = "firefox";
      MOZ_ENABLE_WAYLAND = "1";
    };

    xdg.mimeApps.defaultApplications = {
      "text/html" = [ "firefox.desktop" ];
      "x-scheme-handler/http" = [ "firefox.desktop" ];
      "x-scheme-handler/https" = [ "firefox.desktop" ];
    };
  };
}
