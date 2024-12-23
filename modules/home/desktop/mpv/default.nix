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

  cfg = config.${namespace}.desktop.mpv;
in {
  options.${namespace}.desktop.mpv = {
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
