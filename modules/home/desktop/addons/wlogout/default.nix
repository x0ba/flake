{
  options,
  config,
  lib,
  pkgs,
  inputs,
  namespace,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.desktop.addons.wlogout;
in
{
  options.${namespace}.desktop.addons.wlogout = with types; {
    enable = mkBoolOpt false "Enable or disable wlogout.";
  };

  config = mkIf cfg.enable {

    programs.wlogout = {
      enable = true;
      layout = [
        {
          label = "lock";
          action = "gtklock";
          text = "󰌾";
          keybind = "";
        }
        {
          label = "logout";
          action = "loginctl terminate-user $USER";
          text = "󰗽";
          keybind = "";
        }
        {
          label = "shutdown";
          action = "systemctl poweroff";
          text = "󰐥";
          keybind = "";
        }
        {
          label = "reboot";
          action = "systemctl reboot";
          text = "󰑓";
          keybind = "";
        }
      ];
      style = # css
        ''
          * {
            all: unset;
            font-family: JetBrains Mono Nerd Font;
          }

          window {
            background-color: #1e1e2e;
          }

          button {
            color: #181825;
            font-size: 64px;
            background-color: rgba(0,0,0,0);
            outline-style: none;
            margin: 5px;
          }

          button:focus, button:active, button:hover {
            color: #89b4fa;
            transition: ease 0.4s;
          }

        '';
    };
  };
}

