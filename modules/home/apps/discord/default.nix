{
  lib,
  config,
  inputs,
  pkgs,
  namespace,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  inherit (lib.${namespace}) enabled;

  cfg = config.${namespace}.apps.discord;
in {
  options.${namespace}.apps.discord = {
    enable = mkEnableOption "discord";
  };

  config = mkIf cfg.enable {
    home.packages = [
      (pkgs.discord.override { withOpenASAR = true; })
    ];
  };
}
