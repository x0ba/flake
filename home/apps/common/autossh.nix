{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.app.autossh;
in
{
  options.app.autossh.enable = lib.mkEnableOption "autossh";

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.autossh ];
  };
}
