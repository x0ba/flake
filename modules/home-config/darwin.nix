{
  config,
  lib,
  ...
}:
let
  cfg = config."home-config";
in
{
  imports = [ ./options.nix ];

  config = lib.mkIf cfg.system.homebrewApps.enable {
    app.homebrewApps.enable = lib.mkDefault true;
  };
}
