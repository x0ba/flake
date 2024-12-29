{
  lib,
  config,
  namespace,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.${namespace}.desktop.services;
in {
  options.${namespace}.desktop.services = {
    enable = mkEnableOption "services";
  };

  config = mkIf cfg.enable {
    services = {
      clipman.enable = true;
      gnome-keyring = {
        enable = true;
        components = ["secrets"];
      };
      udiskie.enable = true;
    };
  };
}
