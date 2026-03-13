{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.app.cascadia-code;
in
{
  options.app.cascadia-code.enable = lib.mkEnableOption "Cascadia Code";

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.cascadia-code ];
  };
}
