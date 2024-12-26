{
  lib,
  config,
  pkgs,
  namespace,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.${namespace}.apps.discord;
in
{
  options.${namespace}.apps.discord = {
    enable = mkEnableOption "discord";
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.vesktop
    ];
  };
}
