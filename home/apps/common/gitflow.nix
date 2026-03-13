{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.app.gitflow;
in
{
  options.app.gitflow.enable = lib.mkEnableOption "gitflow";

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.gitflow ];
  };
}
