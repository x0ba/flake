{
  lib,
  config,
  pkgs,
  namespace,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.${namespace}.apps.wlogout;
in
{
  options.${namespace}.apps.wlogout = {
    enable = mkEnableOption "wlogout";
  };

  config = mkIf cfg.enable {

    programs.wlogout = {
      enable = true;
      style = # css
        ''
          * {
          	background-image: none;
          	box-shadow: none;
          }

          window {
          	background-color: rgba(30, 30, 46, 0.90);
          }

          button {
          	border-radius: 0;
          	border-color: #b4befe;
          	text-decoration-color: #cdd6f4;
          	color: #cdd6f4;
          	background-color: #181825;
          	border-style: solid;
          	border-width: 1px;
          	background-repeat: no-repeat;
          	background-position: center;
          	background-size: 25%;
          }

          button:focus, button:active, button:hover {
          	/* 20% Overlay 2, 80% mantle */
          	background-color: rgb(48, 50, 66);
          	outline-style: none;
          }

          #lock {
              background-image: url("file://${./icons/lock.svg}");
          }

          #logout {
              background-image: url("file://${./icons/logout.svg}");
          }

          #suspend {
              background-image: url("file://${./icons/suspend.svg}");
          }

          #hibernate {
              background-image: url("file://${./icons/hibernate.svg}");
          }

          #shutdown {
              background-image: url("file://${./icons/shutdown.svg}");
          }

          #reboot {
              background-image: url("file://${./icons/reboot.svg}");
          }
        '';
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
