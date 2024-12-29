{
  options,
  config,
  pkgs,
  lib,
  namespace,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.desktop.greeter;
in {
  options.${namespace}.desktop.greeter = with types; {
    enable = mkBoolOpt false "Whether or not to enable tuigreet";
  };

  config = mkIf cfg.enable {
    services.gnome.gnome-keyring.enable = true;
    services.greetd = {
      enable = true;
      settings = {
        default_session.command = "${lib.getExe pkgs.greetd.tuigreet} -c niri-session";
        initial_session = {
          command = "niri-session";
          user = "daniel";
        };
      };
    };
    security.pam.services.greetd = {
      enableGnomeKeyring = true;
    };
    security.polkit.enable = true;
    systemd = {
      packages = [pkgs.polkit_gnome];
      user.services.polkit-gnome-authentication-agent-1 = {
        unitConfig = {
          Description = "polkit-gnome-authentication-agent-1";
          Wants = ["graphical-session.target"];
          WantedBy = ["graphical-session.target"];
          After = ["graphical-session.target"];
        };
        serviceConfig = {
          Type = "simple";
          ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
          Restart = "on-failure";
          RestartSec = 1;
          TimeoutStopSec = 10;
        };
      };
    };
  };
}
