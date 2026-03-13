{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.app.fd;
in
{
  options.app.fd.enable = lib.mkEnableOption "fd";

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.fd ];
  };
}
