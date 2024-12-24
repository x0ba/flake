{
  options,
  config,
  pkgs,
  lib,
  inputs,
  namespace,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.desktop.addons.waybar;
in
{
  options.${namespace}.desktop.addons.waybar = with types; {
    enable = mkBoolOpt false "Enable or disable waybar";
  };

  config = mkIf cfg.enable {
    programs.waybar.enable = true;

    home.configFile."waybar/config.jsonc" = {
      source = ./config.jsonc;
      onChange = ''
        ${pkgs.busybox}/bin/pkill -SIGUSR2 waybar
      '';
    };
    home.configFile."waybar/style.css" = {
      text = ''
        * {
          /* `otf-font-awesome` is required to be installed for icons */
          font-family: JetBrainsMono Nerd Font;
          font-size: 13px;
          border-radius: 17px;
        }

        #clock,
        #custom-notification,
        #custom-launcher,
        #custom-power-menu,
        /*#custom-colorpicker,*/
        #custom-window,
        #memory,
        #disk,
        #network,
        #battery,
        #custom-spotify,
        #pulseaudio,
        #window,
        #tray {
          padding: 5 15px;
          border-radius: 12px;
          background: #1e1e2e;
          color: #b4befe;
          margin-top: 8px;
          margin-bottom: 8px;
          margin-right: 2px;
          margin-left: 2px;
          transition: all 0.3s ease;
        }

        #window {
          background-color: transparent;
          box-shadow: none;
        }

        window#waybar {
          background-color: rgba(0, 0, 0, 0.096);
          border-radius: 17px;
        }

        window * {
          background-color: transparent;
          border-radius: 0px;
        }

        #workspaces button label {
          color: #b4befe;
        }

        #workspaces button.active label {
          color: #1e1e2e;
          font-weight: bolder;
        }

        #workspaces button:hover {
          box-shadow: #b4befe 0 0 0 1.5px;
          background-color: #1e1e2e;
          min-width: 50px;
        }

        #workspaces {
          background-color: transparent;
          border-radius: 17px;
          padding: 5 0px;
          margin-top: 3px;
          margin-bottom: 3px;
        }

        #workspaces button {
          background-color: #1e1e2e;
          border-radius: 12px;
          margin-left: 10px;

          transition: all 0.3s ease;
        }

        #workspaces button.active {
          min-width: 50px;
          box-shadow: rgba(0, 0, 0, 0.288) 2 2 5 2px;
          background-color: #f2cdcd;
          background-size: 400% 400%;
          transition: all 0.3s ease;
          background: linear-gradient(
            58deg,
            #cba6f7,
            #cba6f7,
            #cba6f7,
            #89b4fa,
            #89b4fa,
            #cba6f7,
            #f38ba8
          );
          background-size: 300% 300%;
          animation: colored-gradient 20s ease infinite;
        }

        @keyframes colored-gradient {
          0% {
            background-position: 71% 0%;
          }
          50% {
            background-position: 30% 100%;
          }
          100% {
            background-position: 71% 0%;
          }
        }

        #custom-power-menu {
          margin-right: 10px;
          padding-left: 12px;
          padding-right: 15px;
          padding-top: 3px;
        }

        #custom-spotify {
          margin-left: 5px;
          padding-left: 15px;
          padding-right: 15px;
          padding-top: 3px;
          color: #b4befe;
          background-color: #1e1e2e;
          transition: all 0.3s ease;
        }

        #custom-spotify.playing {
          color: rgb(180, 190, 254);
          background: rgba(30, 30, 46, 0.6);
          background: linear-gradient(
            90deg,
            #313244,
            #1e1e2e,
            #1e1e2e,
            #1e1e2e,
            #1e1e2e,
            #313244
          );
          background-size: 400% 100%;
          animation: grey-gradient 3s linear infinite;
          transition: all 0.3s ease;
        }

        @keyframes grey-gradient {
          0% {
            background-position: 100% 50%;
          }
          100% {
            background-position: -33% 50%;
          }
        }

        #tray menu {
          background-color: #1e1e2e;
          opacity: 0.8;
        }

        #pulseaudio.muted {
          color: #f38ba8;
          padding-right: 16px;
        }

        #custom-notification.collapsed,
        #custom-notification.waiting_done {
          min-width: 12px;
          padding-right: 17px;
        }

        #custom-notification.waiting_start,
        #custom-notification.expanded {
          background-color: transparent;
          background: linear-gradient(
            90deg,
            #313244,
            #1e1e2e,
            #1e1e2e,
            #1e1e2e,
            #1e1e2e,
            #313244
          );
          background-size: 400% 100%;
          animation: grey-gradient 3s linear infinite;
          min-width: 500px;
          border-radius: 17px;
        }
      '';
      onChange = ''
        ${pkgs.busybox}/bin/pkill -SIGUSR2 waybar
      '';
    };
  };
}

