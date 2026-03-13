{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.app.pavucontrol;
in
{
  options.app.pavucontrol.enable = lib.mkEnableOption "pavucontrol";

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.pavucontrol ];
  };
}
