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

  cfg = config.${namespace}.apps.mpv;
in {
  options.${namespace}.apps.mpv = {
    enable = mkEnableOption "mpv";
  };

  config = mkIf cfg.enable {
    programs.mpv = {
      enable = true;
      config = {
        hwdec = "auto";
      };
    };
  };
}
