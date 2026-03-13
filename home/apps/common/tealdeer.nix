{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.app.tealdeer;
in
{
  options.app.tealdeer.enable = lib.mkEnableOption "tealdeer";

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.tealdeer ];
  };
}
