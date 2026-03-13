{ pkgs, ... }:
{
  imports = [ ../common/default.nix ];

  home.packages = with pkgs; [
    brightnessctl
    grim
    mako
    pavucontrol
    playerctl
    slurp
    swaybg
    swayidle
    waybar
    pkgs."wl-clipboard"
  ];

  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = "1";
    NIXOS_OZONE_WL = "1";
  };

  programs = {
    foot = {
      enable = true;
      settings = {
        main = {
          font = "Berkeley Mono:size=11";
          pad = "8x8";
          term = "xterm-256color";
        };
        colors = {
          alpha = "0.95";
          background = "1f2430";
          foreground = "d8dee9";
        };
      };
    };

    fuzzel = {
      enable = true;
      settings = {
        main = {
          terminal = "${pkgs.foot}/bin/foot";
          font = "Berkeley Mono:size=12";
          dpi-aware = "yes";
          width = 36;
        };
        border = {
          width = 2;
          radius = 10;
        };
        colors = {
          background = "1f2430ff";
          border = "82aaffff";
          match = "82aaffff";
          selection = "33415cff";
          selection-text = "d8dee9ff";
          text = "d8dee9ff";
        };
      };
    };

    swaylock = {
      enable = true;
      settings = {
        color = "1f2430";
        daemonize = true;
        font = "Berkeley Mono";
        grace = 2;
        indicator = true;
        indicator-radius = 120;
        show-failed-attempts = true;
      };
    };

    waybar = {
      enable = true;
      settings.mainBar = {
        layer = "top";
        position = "top";
        height = 32;
        spacing = 10;
        modules-left = [
          "niri/workspaces"
          "niri/window"
        ];
        modules-center = [ "clock" ];
        modules-right = [
          "tray"
          "network"
          "backlight"
          "pulseaudio"
          "battery"
        ];
        battery = {
          format = "{capacity}% {icon}";
          format-icons = [
            " "
            " "
            " "
            " "
            " "
          ];
          states = {
            warning = 30;
            critical = 15;
          };
        };
        clock.format = "{:%a %b %-d  %H:%M}";
        network = {
          format-ethernet = "eth {ipaddr}";
          format-linked = "link";
          format-wifi = "{essid} {signalStrength}%";
          format-disconnected = "offline";
        };
        pulseaudio = {
          format = "{volume}% {icon}";
          format-bluetooth = "{volume}% bt";
          format-muted = "muted";
          format-icons = {
            default = [
              "vol"
              "vol"
              "vol"
            ];
          };
          on-click = "${pkgs.pavucontrol}/bin/pavucontrol";
        };
      };
      style = ''
        * {
          border: none;
          border-radius: 0;
          font-family: "Berkeley Mono";
          font-size: 13px;
          min-height: 0;
        }

        window#waybar {
          background: rgba(31, 36, 48, 0.92);
          color: #d8dee9;
        }

        #workspaces,
        #window,
        #clock,
        #network,
        #backlight,
        #pulseaudio,
        #battery,
        #tray {
          margin: 6px 0;
          padding: 0 10px;
        }

        #workspaces button {
          color: #82aaff;
          padding: 0 6px;
        }

        #workspaces button.active {
          background: #33415c;
          color: #ffffff;
        }

        #battery.warning,
        #battery.critical {
          color: #ff757f;
        }
      '';
    };
  };

  services.mako = {
    enable = true;
    settings = {
      background-color = "#1f2430f2";
      border-color = "#82aaff";
      border-radius = 10;
      default-timeout = 5000;
      text-color = "#d8dee9";
    };
  };

  xdg.configFile."niri/config.kdl".source = ./files/niri-config.kdl;
}
