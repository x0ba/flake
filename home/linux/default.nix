{
  lib,
  pkgs,
  inputs,
  ...
}:
let
  noctalia =
    cmd:
    [
      "noctalia-shell"
      "ipc"
      "call"
    ]
    ++ lib.splitString " " cmd;
in
{
  imports = [
    ../common/default.nix
    ../common/vscode.nix
    inputs.noctalia.homeModules.default
  ];

  home.packages = with pkgs; [
    brightnessctl
    discord
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
        window-padding-x = 8;
        window-padding-y = 8;
      };
    };

    noctalia-shell = {
      enable = true;
      settings = {
        location = {
          monthBeforeDay = true;
          name = "San Diego";
        };
        colorSchemes.predefinedScheme = "Monochrome";
      };
      systemd.enable = true;
    };

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
            "noctalia-shell ipc call lockScreen toggle"
            "timeout"
            "900"
            "systemctl suspend"
            "before-sleep"
            "noctalia-shell ipc call lockScreen toggle"
          ];
        }
      ];
      "window-rules" = [
        {
          "clip-to-geometry" = true;
          "geometry-corner-radius" = {
            "bottom-left" = 20.0;
            "bottom-right" = 20.0;
            "top-left" = 20.0;
            "top-right" = 20.0;
          };
        }
      ];
      debug = {
        honor-xdg-activation-with-invalid-serial = [ ];
      };
      binds = {
        "Mod+Return".action.spawn = [ "ghostty" ];
        "Mod+Space".action.spawn = noctalia "launcher toggle";
        "Mod+S".action.spawn = noctalia "controlCenter toggle";
        "Mod+Comma".action.spawn = noctalia "settings toggle";
        "Mod+V".action.spawn = noctalia "launcher clipboard";
        "Mod+C".action.spawn = noctalia "launcher calculator";
        "Mod+B".action.spawn = [ "firefox" ];
        "Mod+E".action.spawn = [ "code" ];
        "Mod+N".action.spawn = [
          "nautilus"
          "--new-window"
        ];
        "Mod+Q".action."close-window" = [ ];
        "Mod+Shift+Slash".action."show-hotkey-overlay" = [ ];
        "Mod+Shift+E".action.quit = [ ];
        "Mod+H".action."focus-column-left" = [ ];
        "Mod+L".action."focus-column-right" = [ ];
        "Mod+J".action."focus-window-down" = [ ];
        "Mod+K".action."focus-window-up" = [ ];
        "Mod+BracketRight".action."focus-workspace-down" = [ ];
        "Mod+BracketLeft".action."focus-workspace-up" = [ ];
        "Mod+Shift+H".action."move-column-left" = [ ];
        "Mod+Shift+J".action."move-window-down" = [ ];
        "Mod+Shift+K".action."move-window-up" = [ ];
        "Mod+Shift+L".action."move-column-right" = [ ];
        "Mod+Ctrl+H".action."set-column-width" = "-10%";
        "Mod+Ctrl+L".action."set-column-width" = "+10%";
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
        "XF86MonBrightnessDown".action.spawn = noctalia "brightness decrease";
        "XF86MonBrightnessUp".action.spawn = noctalia "brightness increase";
        "XF86AudioLowerVolume".action.spawn = noctalia "volume decrease";
        "XF86AudioRaiseVolume".action.spawn = noctalia "volume increase";
        "XF86AudioMute".action.spawn = noctalia "volume muteOutput";
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
