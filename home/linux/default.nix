{ pkgs, inputs, ... }:
{
  imports = [
    ../common/default.nix
    ../common/vscode.nix
    inputs.noctalia.homeModules.default
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

    # noctalia-shell = {
    #   enable = true;
    # };

    niri.settings = {
      input = {
        keyboard.xkb.layout = "us";
        touchpad = {
          tap = true;
          "natural-scroll" = true;
          dwt = true;
        };
      };

      layout = {
        gaps = 12;
        "center-focused-column" = "never";
        "default-column-width".proportion = 0.5;
        "preset-column-widths" = [
          { proportion = 0.33333; }
          { proportion = 0.5; }
          { proportion = 0.66667; }
        ];
      };

      "prefer-no-csd" = true;
      "screenshot-path" = "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";
      "spawn-at-startup" = [
        { argv = [ "waybar" ]; }
        {
          argv = [
            "1password"
            "--silent"
          ];
        }
        {
          argv = [
            "swaybg"
            "-c"
            "#1f2430"
          ];
        }
        {
          argv = [
            "swayidle"
            "-w"
            "timeout"
            "600"
            "swaylock -f"
            "timeout"
            "900"
            "systemctl suspend"
            "before-sleep"
            "swaylock -f"
          ];
        }
      ];
      "window-rules" = [
        {
          "clip-to-geometry" = true;
          "geometry-corner-radius" = {
            "bottom-left" = 10.0;
            "bottom-right" = 10.0;
            "top-left" = 10.0;
            "top-right" = 10.0;
          };
        }
      ];
      binds = {
        "Mod+Return".action.spawn = [ "ghostty" ];
        "Mod+D".action.spawn = [ "walker" ];
        "Mod+B".action.spawn = [ "firefox" ];
        "Mod+E".action.spawn = [ "code" ];
        "Mod+N".action.spawn = [
          "nautilus"
          "--new-window"
        ];
        "Mod+Q".action."close-window" = [ ];
        "Mod+Shift+Slash".action."show-hotkey-overlay" = [ ];
        "Mod+Shift+E".action.quit = [ ];
        "Mod+Escape".action.spawn = [
          "swaylock"
          "-f"
        ];
        "Mod+H".action."focus-column-left" = [ ];
        "Mod+J".action."focus-window-down" = [ ];
        "Mod+K".action."focus-window-up" = [ ];
        "Mod+BracketLeft".action."focus-workspace-down" = [ ];
        "Mod+BracketRight".action."focus-workspace-up" = [ ];
        "Mod+L".action."focus-column-right" = [ ];
        "Mod+Semicolon".action."focus-column-right" = [ ];
        "Mod+Shift+H".action."move-column-left" = [ ];
        "Mod+Shift+J".action."move-window-down" = [ ];
        "Mod+Shift+K".action."move-window-up" = [ ];
        "Mod+Shift+L".action."move-column-right" = [ ];
        "Mod+Shift+Semicolon".action."move-column-right" = [ ];
        "Mod+Ctrl+H".action."set-column-width" = "-10%";
        "Mod+Ctrl+L".action."set-column-width" = "+10%";
        "Mod+Ctrl+Semicolon".action."set-column-width" = "+10%";
        "Mod+F".action."maximize-column" = [ ];
        "Mod+Shift+F".action."fullscreen-window" = [ ];
        "Mod+1".action."focus-workspace" = 1;
        "Mod+2".action."focus-workspace" = 2;
        "Mod+3".action."focus-workspace" = 3;
        "Mod+4".action."focus-workspace" = 4;
        "Mod+5".action."focus-workspace" = 5;
        "Mod+6".action."focus-workspace" = 6;
        "Mod+7".action."focus-workspace" = 7;
        "Mod+8".action."focus-workspace" = 8;
        "Mod+9".action."focus-workspace" = 9;
        "Mod+Shift+1".action."move-column-to-workspace" = 1;
        "Mod+Shift+2".action."move-column-to-workspace" = 2;
        "Mod+Shift+3".action."move-column-to-workspace" = 3;
        "Mod+Shift+4".action."move-column-to-workspace" = 4;
        "Mod+Shift+5".action."move-column-to-workspace" = 5;
        "Mod+Shift+6".action."move-column-to-workspace" = 6;
        "Mod+Shift+7".action."move-column-to-workspace" = 7;
        "Mod+Shift+8".action."move-column-to-workspace" = 8;
        "Mod+Shift+9".action."move-column-to-workspace" = 9;
        "Print".action.screenshot = [ ];
        "Ctrl+Print".action."screenshot-screen" = [ ];
        "Alt+Print".action."screenshot-window" = [ ];
        "XF86MonBrightnessDown".action.spawn = [
          "brightnessctl"
          "set"
          "5%-"
        ];
        "XF86MonBrightnessUp".action.spawn = [
          "brightnessctl"
          "set"
          "+5%"
        ];
        "XF86AudioLowerVolume".action.spawn = [
          "pamixer"
          "-d"
          "5"
        ];
        "XF86AudioRaiseVolume".action.spawn = [
          "pamixer"
          "-i"
          "5"
        ];
        "XF86AudioMute".action.spawn = [
          "pamixer"
          "-t"
        ];
        "XF86AudioPlay".action.spawn = [
          "playerctl"
          "play-pause"
        ];
        "XF86AudioNext".action.spawn = [
          "playerctl"
          "next"
        ];
        "XF86AudioPrev".action.spawn = [
          "playerctl"
          "previous"
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
}
