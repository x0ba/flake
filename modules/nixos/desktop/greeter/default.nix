{
  options,
  config,
  pkgs,
  lib,
  namespace,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.desktop.greeter;
in
{
  options.${namespace}.desktop.greeter = with types; {
    enable = mkBoolOpt false "Whether or not to enable tuigreet";
  };

  config = mkIf cfg.enable {
    services.greetd = {
      enable = true;
      settings.default_session.command = lib.getExe pkgs.greetd.tuigreet;
    };
    security.pam.services.greetd = {
      enableGnomeKeyring = true;
      u2fAuth = true;
    };
    security.polkit.enable = true;
  };
}
