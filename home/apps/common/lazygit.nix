{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.app.lazygit;
in
{
  options.app.lazygit.enable = lib.mkEnableOption "Lazygit";

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.lazygit ];
  };
}
