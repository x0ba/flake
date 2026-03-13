{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.app."file-roller";
in
{
  options.app."file-roller".enable = lib.mkEnableOption "File Roller";

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.file-roller ];
  };
}
