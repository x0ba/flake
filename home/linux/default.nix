{ pkgs, ... }:
{
  imports = [
    ../common/default.nix
    ../common/vscode.nix
  ];

  home.packages = with pkgs; [
    brightnessctl
    discord
    elephant
    evince
    file-roller
    firefox
    grim
    loupe
    pavucontrol
    pamixer
    playerctl
    mpv
    nautilus
    obsidian
    slurp
    slack
    spotify
    swaybg
    swayidle
    waybar
    walker
    _1password-gui
    pkgs."wl-clipboard"
  ];

  home.sessionVariables = {
    BROWSER = "firefox";
    MOZ_ENABLE_WAYLAND = "1";
    NIXOS_OZONE_WL = "1";
    TERMINAL = "ghostty";
  };

  dconf.settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";

  home.pointerCursor = {
    gtk.enable = true;
    name = "Bibata-Modern-Ice";
    package = pkgs.bibata-cursors;
    size = 24;
  };

  gtk = {
    enable = true;
    colorScheme = "dark";
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
    gtk4.extraConfig.gtk-application-prefer-dark-theme = 1;
  };

  programs = {
    ghostty = {
      enable = true;
      settings = {
        font-family = "Cascadia Code";
        font-feature = "-liga";
        background-opacity = 0.95;
        window-padding-x = 8;
        window-padding-y = 8;
        keybind = [
          "alt+left=esc:B"
          "alt+right=esc:F"
        ];
      };
    };

    swaylock = {
      enable = true;
      settings = {
        color = "1f2430";
        daemonize = true;
        font = "Cascadia Code";
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
          font-family: "Cascadia Code";
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
          background: rgba(51, 65, 92, 0.7);
          border-radius: 999px;
          margin: 6px 4px;
          padding: 0 12px;
        }

        #workspaces button {
          color: #82aaff;
          border-radius: 999px;
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
      font = "Cascadia Code 11";
      margin = "16";
      padding = "14";
      text-color = "#d8dee9";
    };
  };

  systemd.user.services =
    let
      sessionTarget = [ "graphical-session.target" ];
    in
    {
      elephant = {
        Unit = {
          Description = "Elephant backend for Walker";
          PartOf = sessionTarget;
          After = sessionTarget;
        };
        Service = {
          ExecStart = "${pkgs.elephant}/bin/elephant";
          Restart = "on-failure";
          RestartSec = 2;
        };
        Install.WantedBy = sessionTarget;
      };

      walker-gapplication-service = {
        Unit = {
          Description = "Walker GApplication service";
          PartOf = sessionTarget;
          After = sessionTarget ++ [ "elephant.service" ];
        };
        Service = {
          ExecStart = "${pkgs.walker}/bin/walker --gapplication-service";
          Restart = "on-failure";
          RestartSec = 2;
        };
        Install.WantedBy = sessionTarget;
      };
    };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "application/pdf" = [ "org.gnome.Evince.desktop" ];
      "image/gif" = [ "org.gnome.Loupe.desktop" ];
      "image/jpeg" = [ "org.gnome.Loupe.desktop" ];
      "image/png" = [ "org.gnome.Loupe.desktop" ];
      "inode/directory" = [ "org.gnome.Nautilus.desktop" ];
      "text/html" = [ "firefox.desktop" ];
      "video/mp4" = [ "mpv.desktop" ];
      "x-scheme-handler/http" = [ "firefox.desktop" ];
      "x-scheme-handler/https" = [ "firefox.desktop" ];
    };
  };

  xdg.configFile."niri/config.kdl".source = ./files/niri-config.kdl;
}
