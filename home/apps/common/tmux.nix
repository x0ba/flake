{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.app.tmux;
in
{
  options.app.tmux.enable = lib.mkEnableOption "tmux";

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.tmux ];
  };
}
