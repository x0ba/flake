{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.app.spotify;
in
{
  options.app.spotify.enable = lib.mkEnableOption "Spotify";

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.spotify ];
  };
}
