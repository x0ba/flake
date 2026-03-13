{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.app."pre-commit";
in
{
  options.app."pre-commit".enable = lib.mkEnableOption "pre-commit";

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs."pre-commit" ];
  };
}
