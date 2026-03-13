{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.app.discord;
in
{
  options.app.discord.enable = lib.mkEnableOption "Discord";

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.discord ];
  };
}
