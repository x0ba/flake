{
  lib,
  pkgs,
  config,
  namespace,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  inherit (lib.${namespace}) enabled;

  cfg = config.${namespace}.cli.borgmatic;
in {
  options.${namespace}.cli.borgmatic = {
    enable = mkEnableOption "borgmatic";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      borgmatic
    ];
    sops.secrets."borgmatic-phantom".path = "${config.xdg.configHome}/borgmatic/config.yaml";
  };
}
