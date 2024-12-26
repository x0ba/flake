{
  lib,
  config,
  namespace,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.${namespace}.apps.waybar;
in
{
  options.${namespace}.apps.waybar = {
    enable = mkEnableOption "waybar";
  };

  config = mkIf cfg.enable {
    programs.waybar = {
      enable = true;
      settings = [
        {
          layer = "top";
          position = "top";
          height = 32;
          spacing = 0;
          fixed-center = false;
          modules-left = [
            "niri/workspaces"
          ];
          modules-center = [
            "niri/window"
          ];
          modules-right = [
            "tray"
            "battery"
            "clock"
          ] ++ lib.optionals config.skibidi.apps.swaync.enable [ "custom/swaync" ];
          "niri/window" = {
            max-length = 50;
            max-length-mode = "middle";
            tooltip = true;
          };
          "custom/swaync" = {
            tooltip = false;
            format = "{icon}";
            format-icons = {
              notification = "<span foreground='red'><sup></sup></span>";
              none = "";
              dnd-notification = "<span foreground='red'><sup></sup></span>";
              dnd-none = "";
              inhibited-notification = "<span foreground='red'><sup></sup></span>";
              inhibited-none = "";
              dnd-inhibited-notification = "<span foreground='red'><sup></sup></span>";
              dnd-inhibited-none = "";
            };
            return-type = "json";
            exec-if = "which swaync-client";
            exec = "swaync-client -swb";
            on-click = "swaync-client -t -sw";
            on-click-right = "swaync-client -d -sw";
            escape = true;
          };
          "niri/workspaces" = {
            disable-scroll = false;
            all-outputs = false;
            format = "";
            persistent_workspaces = {
              "1" = [
                "eDP-1"
                "DP-3"
              ];
              "2" = [
                "eDP-1"
                "DP-3"
              ];
              "3" = [
                "eDP-1"
                "DP-3"
              ];
              "4" = [
                "eDP-1"
                "DP-3"
              ];
              "5" = [
                "eDP-1"
                "DP-3"
              ];
              "6" = [
                "DP-1"
                "DP-3"
              ];
              "7" = [
                "DP-1"
              ];
              "8" = [
                "DP-1"
              ];
              "9" = [
                "DP-1"
              ];
              "10" = [
                "DP-1"
              ];
            };
          };
          clock = {
            timezone = "America/Los_Angeles";
            format = "󰅐  {:%a %I:%M %p}";
            tooltip-format = "<tt><small>{calendar}</small></tt>";
            format-alt = "󰅐  {:%a %d.%m.%Y %I:%M %p}";
          };
          cpu = {
            format = "󰘚 {usage}%";
            tooltip = true;
          };
          memory = {
            format = "󰍛 {}%";
          };
          temperature = {
            critical-threshold = 70;
            interval = 3;
            format = "{icon} {temperatureC}°C";
            format-icons = [
              "󱃃"
              "󰔏"
              "󱃂"
            ];
          };
          battery = {
            interval = 10;
            states = {
              critical = 25;
            };
            format = "{icon} {capacity}%";
            format-charging = "󰂄 {capacity}%";
            format-icons = [
              "󰂎"
              "󰁺"
              "󰁻"
              "󰁼"
              "󰁽"
              "󰁾"
              "󰁿"
              "󰂀"
              "󰂁"
              "󰂂"
              "󰁹"
            ];
          };
        }
      ];
      style =
        # css
        ''
          * {
              font-family: Inter, sans-serif;
              font-size: 16px;
          }

          window#waybar {
              background-color: #1e1e2e;
              color: rgba(255, 255, 255, 0.87);
          }

          button {
              border: none;
              border-radius: 0;
              transition: background ease-in-out 0.2s;
          }

          button:hover {
              background: rgba(255, 255, 255, 0.06);
          }

          #workspaces button {
              padding: 0;
          }

          #workspaces button label {
              background: rgba(255, 255, 255, 0.14);
              font-size: 0;
              color: transparent;
              min-width: 10px;
              min-height: 10px;
              margin: calc(1rem - 2px) 0.8rem;
              padding: 1px;
              border-radius: 3px;
          }

          #workspaces button.persistent label {
              padding: 0;
              background: transparent;
              border: 1px solid rgba(255, 255, 255, 0.14);
          }

          #workspaces button.focused label {
              background: rgba(255, 255, 255, 0.87);
          }

          #workspaces button.urgent label {
              background: #E36D6D;
          }

          .modules-right widget > * {
              padding: 0 0.8em;
          }

          widget #tray {
              padding: 0;
          }

          #battery.critical {
              background: rgba(218, 88, 88, 0.3);
          }
        '';
    };
  };
}
