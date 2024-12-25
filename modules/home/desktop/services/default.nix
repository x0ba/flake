{
  lib,
  config,
  pkgs,
  namespace,
  ...
}: let
  inherit (pkgs.stdenv) isLinux;
  inherit (lib) mkEnableOption mkIf;

  cfg = config.${namespace}.desktop.services;
in {
  options.${namespace}.desktop.services = {
    enable = mkEnableOption "services";
  };

  config = mkIf cfg.enable {
    services = {
      clipman.enable = true;
      # wlsunset = {
      #   enable = true;
      #   latitude = "37.4";
      #   longitude = "-121.8";
      # };
      udiskie.enable = true;
    };
  };
}
