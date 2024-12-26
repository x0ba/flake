{
  lib,
  config,
  inputs,
  namespace,
  pkgs,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;

  mod = "Mod4";
  modMove = "${mod}+Shift";
  modFocus = "${mod}+Ctrl";
  hyper = "Mod4+Mod1+Shift+Ctrl";

  filebrowser = "${lib.getExe pkgs.nautilus} -w";
  playerctl = lib.getExe pkgs.playerctl;
  screenshot = "${lib.getExe pkgs.sway-contrib.grimshot} copy area";
  swayosd-client = "${config.services.swayosd.package}/bin/swayosd-client";
  swayosd-server = "${config.services.swayosd.package}/bin/swayosd-server";

  cfg' = config.wayland.windowManager.sway.config;
  cfg = config.${namespace}.desktop.sway;
in
{
  options.${namespace}.desktop.sway = {
    enable = mkEnableOption "sway";
  };

  config = mkIf cfg.enable {
    services = {
      clipman.enable = true;
      swayosd.enable = true;
      gnome-keyring = {
        enable = true;
        components = [ "secrets" ];
      };
      udiskie.enable = true;
    };
    wayland.windowManager.sway = {
      enable = true;
      package = null;
      checkConfig = false;
      config = {
        modifier = mod;
        focus.wrapping = "no";
        focus.mouseWarping = "container";
        startup = [
          { command = "${lib.getExe pkgs.autotiling} -l2"; }
          { command = "1password --silent"; }
          {
            command = ''
              ${lib.getExe pkgs.swayidle} -w \
                timeout 300 'swaymsg "output * dpms off"' \
                resume 'swaymsg "output * dpms on"' \
                before-sleep '${lib.getExe config.programs.swaylock.package} -f'
            '';
          }
          { command = swayosd-server; }
          { command = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"; }
        ];
        workspaceAutoBackAndForth = true;
        # TODO: change this back to wezterm whenever it works on sway
        terminal = lib.getExe inputs.ghostty.packages.x86_64-linux.default;
        menu = "${lib.getExe config.programs.rofi.package} -show drun -dpi $dpi";
        defaultWorkspace = "workspace number 1";
        input."type:keyboard".xkb_options = "ctrl:nocaps,compose:ralt";
        output."*" = {
          scale = "1.25";
          bg = "${../../../../assets/house.png} fill #171320";
        };
        keybindings = {
          "${mod}+Shift+b" = "border none";
          "${mod}+b" = "border pixel 2";
          "${mod}+n" = "border normal";
          # reload the configuration file
          "${mod}+Shift+r" = "reload";
          # kill focused window
          "${mod}+Shift+q" = "kill";
          # Start Applications
          "${mod}+Shift+Return" = "exec ghostty";
          "${mod}+e" = "exec ${filebrowser}";
          "${hyper}+p" = "exec ${screenshot}";

          # change focus
          "${modFocus}+h" = "focus left";
          "${modFocus}+j" = "focus down";
          "${modFocus}+k" = "focus up";
          "${modFocus}+l" = "focus right";
          "${modFocus}+Left" = "focus left";
          "${modFocus}+Down" = "focus down";
          "${modFocus}+Up" = "focus up";
          "${modFocus}+Right" = "focus right";
          # move focus
          "${modMove}+h" = "move left";
          "${modMove}+j" = "move down";
          "${modMove}+k" = "move up";
          "${modMove}+l" = "move right";
          "${modMove}+Left" = "move left";
          "${modMove}+Down" = "move down";
          "${modMove}+Up" = "move up";
          "${modMove}+Right" = "move right";

          # move workspaces across monitors
          "${modMove}+greater" = "move workspace to output right";
          "${modMove}+less" = "move workspace to output left";

          # split orientation
          "${mod}+q" = "split toggle";

          # toggle fullscreen mode for the focused container
          "${mod}+f" = "fullscreen toggle";

          # change container layout (stacked, tabbed, toggle split)
          "${mod}+s" = "layout toggle";

          # toggle tiling / floating
          "${mod}+Shift+d" = "floating toggle";
          # change focus between tiling / floating windows
          "${mod}+d" = "focus mode_toggle";

          # toggle sticky
          "${mod}+Shift+s" = "sticky toggle";

          # focus the parent container
          "${mod}+a" = "focus parent";

          # move the currently focused window to the scratchpad
          "${mod}+Shift+Tab" = "move scratchpad";
          # Show the next scratchpad window or hide the focused scratchpad window.
          # If there are multiple scratchpad windows, this command cycles through them.
          "${mod}+Tab" = "scratchpad show";
          "${mod}+m" = "[app_id=\"discord\"] scratchpad show";

          # switch to workspace
          "${modFocus}+1" = "workspace number 1";
          "${modFocus}+2" = "workspace number 2";
          "${modFocus}+3" = "workspace number 3";
          "${modFocus}+4" = "workspace number 4";
          "${modFocus}+5" = "workspace number 5";
          "${modFocus}+6" = "workspace number 6";
          "${modFocus}+7" = "workspace number 7";
          "${modFocus}+8" = "workspace number 8";
          "${modFocus}+9" = "workspace number 9";
          "${modFocus}+0" = "workspace number 10";
          # Move to workspace with focused container
          "${modMove}+1" = "move container to workspace number 1;  workspace number 1";
          "${modMove}+2" = "move container to workspace number 2;  workspace number 2";
          "${modMove}+3" = "move container to workspace number 3;  workspace number 3";
          "${modMove}+4" = "move container to workspace number 4;  workspace number 4";
          "${modMove}+5" = "move container to workspace number 5;  workspace number 5";
          "${modMove}+6" = "move container to workspace number 6;  workspace number 6";
          "${modMove}+7" = "move container to workspace number 7;  workspace number 7";
          "${modMove}+8" = "move container to workspace number 8;  workspace number 8";
          "${modMove}+9" = "move container to workspace number 9;  workspace number 9";
          "${modMove}+0" = "move container to workspace number 10; workspace number 10";
          # rofi instead of drun
          "${mod}+space" = "exec ${cfg'.menu}";
          # 1password
          "${mod}+Shift+space" = "exec ${lib.getExe pkgs._1password-gui} --quick-access";

          # audio
          "XF86AudioRaiseVolume" = "exec ${swayosd-client} --output-volume 5";
          "XF86AudioLowerVolume" = "exec ${swayosd-client} --output-volume -5";
          "XF86AudioMute" = "exec ${swayosd-client} --output-volume mute-toggle";
          "XF86AudioNext" = "exec --no-startup-id ${playerctl} next";
          "XF86AudioPrev" = "exec --no-startup-id ${playerctl} previous";
          "XF86AudioPlay" = "exec --no-startup-id ${playerctl} play-pause";

          # modes
          "${mod}+r" = "mode \"resize\"";
          "${mod}+p" = "mode \"power: (l)ock, (e)xit, (r)eboot, (s)uspend, (S)hut off\"";
        };
        modes = {
          "power: (l)ock, (e)xit, (r)eboot, (s)uspend, (S)hut off" = {
            l = "exec --no-startup-id swaylock, mode \"default\"";
            e = "exec --no-startup-id swaymsg exit, mode \"default\"";
            r = "exec --no-startup-id systemctl reboot, mode \"default\"";
            s = "exec --no-startup-id systemctl sleep, mode \"default\"";
            "Shift+s" = "exec --no-startup-id systemctl poweroff, mode \"default\"";
            Escape = "mode default";
            Return = "mode default";
          };
          resize = {
            Escape = "mode default";
            Return = "mode default";
            h = "resize shrink width 10 px or 10 ppt";
            j = "resize grow height 10 px or 10 ppt";
            k = "resize shrink height 10 px or 10 ppt";
            l = "resize grow width 10 px or 10 ppt";
            R = "resize set 50 ppt 50 ppt";
          };
        };
        fonts = {
          names = [
            "Inter"
            "Symbols Nerd Font"
          ];
          size = 12.0;
        };
        window = {
          titlebar = false;
          hideEdgeBorders = "none";
          border = 2;
        };
        gaps = {
          inner = 5;
          outer = 2;
        };
      };

      extraConfig = ''
        set $rosewater #f5e0dc
        set $flamingo #f2cdcd
        set $pink #f5c2e7
        set $mauve #cba6f7
        set $red #f38ba8
        set $maroon #eba0ac
        set $peach #fab387
        set $yellow #f9e2af
        set $green #a6e3a1
        set $teal #94e2d5
        set $sky #89dceb
        set $sapphire #74c7ec
        set $blue #89b4fa
        set $lavender #b4befe
        set $text #cdd6f4
        set $subtext1 #bac2de
        set $subtext0 #a6adc8
        set $overlay2 #9399b2
        set $overlay1 #7f849c
        set $overlay0 #6c7086
        set $surface2 #585b70
        set $surface1 #45475a
        set $surface0 #313244
        set $base #1e1e2e
        set $mantle #181825
        set $crust #11111b

        for_window [floating] border pixel 2

        # floating sticky
        for_window [class="1Password"] floating enable sticky enable
        for_window [window_role="PictureInPicture"] floating enable sticky enable
        for_window [title="Picture in picture"] floating enable sticky enable

        # floating
        for_window [class="GParted"] floating enable
        for_window [title="(?i)SteamTinkerLaunch"] floating enable
        for_window [title="Blender Render"] floating enable

        # general WM role settings
        for_window [title="splash"] floating enable
        for_window [urgent=latest] focus
        for_window [window_role="dialog"] floating enable
        for_window [window_role="pop-up"] floating enable
        for_window [window_role="task_dialog"] floating enable
        for_window [window_type="dialog"] floating enable

        # apps
        for_window [app_id="org.pulseaudio.pavucontrol"] floating enable
        for_window [app_id="org.gnome.NautilusPreviewer"] floating enable
        for_window [class="Yad" title="Authentication"] floating enable
        for_window [app_id="jetbrains*" title="Welcome*"] floating enable
        for_window [class="jetbrains*" title="Welcome*"] floating enable
        for_window [title="File Transfer*"] floating enable
        for_window [title="Steam Guard*"] floating enable

        # keep apps in scratchpad
        for_window [app_id="discord"] move scratchpad sticky
        for_window [app_id="vesktop"] move scratchpad sticky

        # fullscreen apps inhibit idle
        for_window [class=".*"] inhibit_idle fullscreen

        set $mode_gaps Gaps: (o)uter, (i)nner
        set $mode_gaps_outer Outer Gaps: +|-|0 (local), Shift + +|-|0 (global)
        set $mode_gaps_inner Inner Gaps: +|-|0 (local), Shift + +|-|0 (global)
        bindsym ${mod}+Shift+g mode "$mode_gaps"

        mode "$mode_gaps" {
          bindsym o      mode "$mode_gaps_outer"
          bindsym i      mode "$mode_gaps_inner"
          bindsym Return mode "$mode_gaps"
          bindsym Escape mode "default"
        }
        mode "$mode_gaps_outer" {
          bindsym plus  gaps outer current plus 5
          bindsym minus gaps outer current minus 5
          bindsym 0     gaps outer current set 0

          bindsym Shift+plus  gaps outer all plus 5
          bindsym Shift+minus gaps outer all minus 5
          bindsym Shift+0     gaps outer all set 0

          bindsym Return mode "$mode_gaps"
          bindsym Escape mode "default"
        }
        mode "$mode_gaps_inner" {
          bindsym plus  gaps inner current plus 5
          bindsym minus gaps inner current minus 5
          bindsym 0     gaps inner current set 0

          bindsym Shift+plus  gaps inner all plus 5
          bindsym Shift+minus gaps inner all minus 5
          bindsym Shift+0     gaps inner all set 0

          bindsym Return mode "$mode_gaps"
          bindsym Escape mode "default"

          client.focused           $lavender $base $text  $rosewater $lavender
          client.focused_inactive  $overlay0 $base $text  $rosewater $overlay0
          client.unfocused         $overlay0 $base $text  $rosewater $overlay0
          client.urgent            $peach    $base $peach $overlay0  $peach
          client.placeholder       $overlay0 $base $text  $overlay0  $overlay0
          client.background        $base
        }
      '';
      systemd = {
        enable = true;
        xdgAutostart = true;
        variables = [
          "DISPLAY"
          "WAYLAND_DISPLAY"
          "SWAYSOCK"
          "XDG_CURRENT_DESKTOP"
          "XDG_SESSION_TYPE"
          "NIXOS_OZONE_WL"
          "XCURSOR_THEME"
          "XCURSOR_SIZE"
          "PATH"
        ];
      };
    };
  };
}
