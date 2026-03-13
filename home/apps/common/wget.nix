{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.app.wget;
in
{
  options.app.wget.enable = lib.mkEnableOption "wget";

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.wget ];
  };
}
