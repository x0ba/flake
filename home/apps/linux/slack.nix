{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.app.slack;
in
{
  options.app.slack.enable = lib.mkEnableOption "Slack";

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.slack ];
  };
}
