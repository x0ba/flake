{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.app.htop;
in
{
  options.app.htop.enable = lib.mkEnableOption "htop";

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.htop ];
  };
}
