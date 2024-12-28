{
  lib,
  pkgs,
  config,
  namespace,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.${namespace}.apps.spotify;
in {
  options.${namespace}.apps.spotify = {
    enable = mkEnableOption "spotify";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      spotify
    ];
  };
}
