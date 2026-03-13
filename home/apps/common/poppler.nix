{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.app.poppler;
in
{
  options.app.poppler.enable = lib.mkEnableOption "Poppler";

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.poppler ];
  };
}
