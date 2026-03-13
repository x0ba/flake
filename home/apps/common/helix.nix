{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.app.helix;
in
{
  options.app.helix.enable = lib.mkEnableOption "Helix";

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.helix ];
  };
}
