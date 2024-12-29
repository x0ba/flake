{
  lib,
  config,
  namespace,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.${namespace}.apps.wlogout;
in {
  options.${namespace}.apps.wlogout = {
    enable = mkEnableOption "wlogout";
  };

  config = mkIf cfg.enable {
    programs.wlogout = {
      enable = true;
      layout = [
        {
          "label" = "lock";
          "action" = "${lib.getExe config.programs.swaylock.package}";
          "keybind" = "l";
          "text" = "Lock";
        }
        {
          "label" = "logout";
          "action" = "loginctl terminate-user $USER";
          "keybind" = "o";
          "text" = "Logout";
        }
        {
          "label" = "suspend";
          "action" = "systemctl suspend";
          "keybind" = "s";
          "text" = "Suspend";
        }
        {
          "label" = "shutdown";
          "action" = "systemctl poweroff";
          "keybind" = "p";
          "text" = "Shutdown";
        }
        {
          "label" = "reboot";
          "action" = "systemctl reboot";
          "keybind" = "r";
          "text" = "Reboot";
        }
        {
          "label" = "hibernate";
          "action" = "systemctl hibernate";
          "keybind" = "h";
          "text" = "Hibernate";
        }
      ];
    };
  };
}
