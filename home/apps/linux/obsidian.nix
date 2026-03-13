{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.app.obsidian;
in
{
  options.app.obsidian.enable = lib.mkEnableOption "Obsidian";

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.obsidian ];
  };
}
