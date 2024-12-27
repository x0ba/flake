{
  lib,
  pkgs,
  config,
  namespace,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  inherit (pkgs.stdenv.hostPlatform) isLinux;

  cfg = config.${namespace}.apps.syncthing;
in {
  options.${namespace}.apps.syncthing = {
    enable = mkEnableOption "syncthing";
  };

  config = mkIf cfg.enable {
    home.persistence."/persist/home".directories =
      if isLinux
      then [
        ".local/state/syncthing"
      ]
      else [];
    services.syncthing = {
      enable = true;
    };
  };
}
