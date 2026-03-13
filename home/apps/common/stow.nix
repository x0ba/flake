{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.app.stow;
in
{
  options.app.stow.enable = lib.mkEnableOption "Stow";

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.stow ];
  };
}
