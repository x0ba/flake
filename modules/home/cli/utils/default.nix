{
  lib,
  config,
  pkgs,
  namespace,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.${namespace}.cli.utils;
  inherit (pkgs.stdenv) isLinux;
in {
  options.${namespace}.cli.utils = {
    enable = mkEnableOption "misc cli utils";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      dwt1-shell-color-scripts
      htop
      gocryptfs
      gh
      onefetch
      fd
      ripgrep
      file
      ffmpeg
      manix
      just
      yt-dlp
    ];
    home = {
      sessionVariables.LESS = "-R --use-color";
      shellAliases = {
        # switch between yubikeys for the same GPG key
        switch_yubikeys = ''gpg-connect-agent "scd serialno" "learn --force" "/bye"'';

        # podman
        docker = lib.mkIf isLinux "podman";
        docker-compose = lib.mkIf isLinux "podman-compose";
      };
    };
    programs = {
      fzf = {
        enable = true;
        colors = {
          fg = "#cdd6f4";
          "fg+" = "#cdd6f4";
          hl = "#f38ba8";
          "hl+" = "#f38ba8";
          header = "#ff69b4";
          info = "#cba6f7";
          marker = "#f5e0dc";
          pointer = "#f5e0dc";
          prompt = "#cba6f7";
          spinner = "#f5e0dc";
        };
        defaultOptions = [
          "--height=30%"
          "--layout=reverse"
          "--info=inline"
        ];
      };

      less.enable = true;

      atuin = {
        enable = true;
        flags = ["--disable-up-arrow"];
        settings = {
          inline_height = 30;
          style = "compact";
          sync_frequency = "5m";
        };
      };

      eza = {
        enable = true;
        icons = "auto";
        extraOptions = [
          "--group"
          "--group-directories-first"
          "--no-permissions"
          "--octal-permissions"
        ];
      };
      bat.enable = true;
      btop = {
        enable = true;
        settings = {
          theme_background = false;
          vim_keys = true;
        };
      };

      nix-index-database.comma.enable = true;
      zoxide.enable = true;
      tealdeer = {
        enable = true;
        settings = {
          style = {
            description.foreground = "white";
            command_name.foreground = "green";
            example_text.foreground = "blue";
            example_code.foreground = "white";
            example_variable.foreground = "yellow";
          };
          updates.auto_update = true;
        };
      };
      starship = {
        enable = true;
        settings = {
          command_timeout = 3000;
          format = "$hostname$username$nix_shell$character";
          right_format = "$directory\${custom.jjid}\${custom.jjstat}$git_state$git_commit$git_status";

          character = {
            success_symbol = "[ λ ](fg:black bg:cyan)";
            error_symbol = "[ λ ](fg:black bg:red)";
            vimcmd_symbol = "[ Λ ](fg:black bg:purple)";
            vimcmd_replace_symbol = "[ Λ ](fg:black bg:green)";
            vimcmd_replace_one_symbol = "[ Λ ](fg:black bg:green)";
            vimcmd_visual_symbol = "[ Λ ](fg:black bg:yellow)";
          };

          username = {
            style_user = "bg:purple fg:black";
            style_root = "bg:red fg:black";
            format = "[ $user ]($style)";
            disabled = false;
            show_always = true;
          };

          hostname = {
            style = "fg:black bg:blue";
            ssh_only = true;
            ssh_symbol = "";
            format = "[ ✦ $hostname ✦ ]($style)";
            disabled = false;
          };

          git_commit = {
            style = "fg:black bg:purple";
            format = ''[ $hash$tag ]($style)'';
          };

          git_state = {
            style = "fg:black bg:red";
            format = "[ $state $progress_current/$progress_total ]($style)";
          };

          git_status = {
            style = "fg:black bg:red";
            ahead = "▲";
            behind = "▼";
            conflicted = "±";
            deleted = "×";
            diverged = "◊";
            up_to_date = "√";
            modified = "‼";
            staged = "+";
            renamed = "≡";
            stashed = "▽";
            untracked = "?";
            format = ''[( $all_status$ahead_behind )]($style)'';
          };

          git_branch = {
            style = "fg:black bg:green";
            format = "[ $symbol$branch(:$remote_branch) ]($style)";
            symbol = "";
          };

          battery.disabled = true;
          line_break.disabled = true;

          directory = {
            truncation_length = 2;
            style = "bg:blue fg:black";
            read_only_style = "bg:red fg:black";
            read_only = " RO ";
            format = "[$read_only]($read_only_style)[ $path ]($style)";
          };

          nix_shell = {
            style = "fg:black bg:yellow";
            format = "[ $name ]($style)";
          };

          custom = {
            jjid = {
              ignore_timeout = true;
              description = "current jj revision";
              when = "jj root";
              command = "jj log -r@ --no-graph --ignore-working-copy --color never --limit 1 -T 'change_id.shortest(4)'";
              style = "fg:black bg:green";
              format = "[ $output ]($style)";
            };

            jjstat = {
              ignore_timeout = true;
              description = "current jj bookmark status";
              when = "jj root";
              style = "fg:black bg:red";
              format = "[( $output )]($style)";
              command = ''
                jj log -r@ -n1 --ignore-working-copy --no-graph --color never -T '
                  separate("",
                    if(!empty, "∆"),
                    if(conflict, "${config.programs.starship.settings.git_status.conflicted}"),
                    if(divergent, "${config.programs.starship.settings.git_status.diverged}"),
                    if(hidden, "${config.programs.starship.settings.git_status.deleted}"),
                    if(immutable, "λ"),
                    if(git_head, "★"),
                    if(root, "☆")
                  )
                '
              '';
            };
          };
        };
      };
      direnv = {
        enable = true;
        nix-direnv.enable = true;
      };
      nix-index.enable = true;
    };
  };
}
