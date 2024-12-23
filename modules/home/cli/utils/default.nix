{
  lib,
  config,
  pkgs,
  namespace,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  inherit (lib.${namespace}) enabled;

  cfg = config.${namespace}.cli.utils;
in
{
  options.${namespace}.cli.utils = {
    enable = mkEnableOption "misc cli utils";
  };

  config = mkIf cfg.enable { 
    home.packages = [
      pkgs.dwt1-shell-color-scripts
      pkgs.gcc
    ];
    programs = {
      fzf.enable = true;
      zoxide.enable = true;
      starship.enable = true;
    };
  };
}
