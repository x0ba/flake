{
  config,
  lib,
  pkgs,
  user,
  ...
}:
let
  commonPackages = [
    pkgs.autossh
    pkgs.fd
    pkgs.gitflow
    pkgs.helix
    pkgs.htop
    pkgs.lazygit
    pkgs.poppler
    pkgs.stow
    pkgs.tealdeer
    pkgs.tmux
    pkgs.vim
    pkgs.wget
    pkgs.yubikey-manager
    pkgs."git-lfs"
    pkgs."pre-commit"
    pkgs."yubikey-personalization"
  ];
in
{
  home = {
    username = user;
    homeDirectory = if pkgs.stdenv.isDarwin then "/Users/${user}" else "/home/${user}";
    stateVersion = "25.05";

    sessionPath = [
      "$HOME/.bun/bin"
      "$HOME/.local/bin"
      "$HOME/bin"
    ];

    sessionVariables = {
      BUN_INSTALL = "$HOME/.bun";
      EDITOR = "vim";
      VISUAL = "vim";
    };

    packages = commonPackages;
  };

  xdg.enable = true;

  programs = {
    home-manager.enable = true;

    bash.enable = true;

    bat.enable = true;
    btop = {
      enable = true;
      settings = {
        color_theme = "Default";
        theme_background = true;
        truecolor = true;
        force_tty = false;
        presets = "cpu:1:default,proc:0:default cpu:0:default,mem:0:default,net:0:default cpu:0:block,net:0:tty";
        vim_keys = false;
        rounded_corners = true;
        terminal_sync = true;
        graph_symbol = "braille";
        graph_symbol_cpu = "default";
        graph_symbol_mem = "default";
        graph_symbol_net = "default";
        graph_symbol_proc = "default";
        shown_boxes = "cpu mem net proc";
        update_ms = 2000;
        proc_sorting = "cpu lazy";
        proc_reversed = false;
        proc_tree = false;
        proc_colors = true;
        proc_gradient = true;
        proc_per_core = false;
        proc_mem_bytes = true;
        proc_cpu_graphs = true;
        proc_info_smaps = false;
        proc_left = false;
        proc_filter_kernel = false;
        proc_aggregate = false;
        keep_dead_proc_usage = false;
        cpu_graph_upper = "Auto";
        cpu_graph_lower = "Auto";
        cpu_invert_lower = true;
        cpu_single_graph = false;
        cpu_bottom = false;
        show_uptime = true;
        show_cpu_watts = true;
        check_temp = true;
        cpu_sensor = "Auto";
        show_coretemp = true;
        cpu_core_map = "";
        temp_scale = "celsius";
        base_10_sizes = false;
        show_cpu_freq = true;
        clock_format = "%X";
        background_update = true;
        custom_cpu_name = "";
        disks_filter = "";
        mem_graphs = true;
        mem_below_net = false;
        zfs_arc_cached = true;
        show_swap = true;
        swap_disk = true;
        show_disks = true;
        only_physical = true;
        use_fstab = true;
        zfs_hide_datasets = false;
        disk_free_priv = false;
        show_io_stat = true;
        io_mode = false;
        io_graph_combined = false;
        io_graph_speeds = "";
      };
    };
    carapace = {
      enable = true;
      enableZshIntegration = true;
    };
    codex = {
      enable = true;
      custom-instructions = ''
        Prefer functional programming patterns, avoid explicit returns types unless you absolutely need to, and be concise in the code you write, but be through in your planning. 
        When installing packages, use the package manager for that language. For example in Typescript DO NOT just update the package.json file with the new package, but rather run "bun add ..." to install it. 
        ALWAYS USE BUN. NEVER EVER EVER EVER USE NPM OR PNPM OR YARN OR ANY OF THAT OTHER GARBAGE IN TS PROJECT. IF YOU HAVE TO, YOU MUST BEG ME TO USE ANYTHING OTHER THAN BUN OR I WILL FUCKING UNPLUG YOU.
        Make sure you always run the "check" and "format" commands after making changes for that project. If they don't currently exist in the project, add logical ones for that language. 
        When asking sets of questions, always include numbers so it's easy for me to clearly answer.
      '';
    };
    claude-code.enable = true;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    eza.enable = true;
    fzf.enable = true;

    git = {
      enable = true;
      lfs.enable = true;
      settings = {
        push.autoSetupRemote = true;
        user = {
          email = "hi@danielx.me";
          name = "Daniel Xu";
        };
      };
    };

    gh = {
      enable = true;
      settings = {
        git_protocol = "https";
        prompt = "enabled";
        prefer_editor_prompt = "disabled";
        aliases.co = "pr checkout";
        color_labels = "disabled";
        accessible_colors = "disabled";
        accessible_prompter = "disabled";
        spinner = "enabled";
      };
    };
    jujutsu = {
      enable = true;
      settings = {
        user = {
          name = "Daniel Xu";
          email = "hi@danielx.me";
        };
        remotes.origin.auto-track-bookmarks = "*";
      };
    };
    mise = {
      enable = true;
      enableZshIntegration = true;
      globalConfig.tools.node = "lts";
    };
    pyenv = {
      enable = true;
      enableZshIntegration = true;
      rootDirectory = config.home.homeDirectory + "/.pyenv";
    };
    starship = {
      enable = true;
      settings = {
        "$schema" = "https://starship.rs/config-schema.json";
        format = lib.concatStrings [
          "$username"
          "$hostname"
          "$directory"
          "$git_branch"
          "$git_state"
          "$git_status"
          "$cmd_duration"
          "$line_break"
          "$python"
          "$character"
        ];
        directory.style = "blue";
        character = {
          success_symbol = "[❯](purple)";
          error_symbol = "[❯](red)";
          vimcmd_symbol = "[❮](green)";
        };
        git_branch = {
          format = "[$branch]($style)";
          style = "bright-black";
        };
        git_status = {
          format = "[[(*$conflicted$untracked$modified$staged$renamed$deleted)](218) ($ahead_behind$stashed)]($style)";
          style = "cyan";
          conflicted = "​";
          untracked = "​";
          modified = "​";
          staged = "​";
          renamed = "​";
          deleted = "​";
          stashed = "≡";
        };
        git_state = {
          format = "\\([$state( $progress_current/$progress_total)]($style)\\) ";
          style = "bright-black";
        };
        cmd_duration = {
          format = "[$duration]($style) ";
          style = "yellow";
        };
        python = {
          format = "[$virtualenv]($style) ";
          style = "bright-black";
          detect_extensions = [ ];
          detect_files = [ ];
        };
      };
    };
    yazi = {
      enable = true;
      shellWrapperName = "yy";
    };
    zellij.enable = true;
    zoxide.enable = true;

    zsh = {
      enable = true;
      autosuggestion.enable = true;
      dotDir = config.home.homeDirectory;
      syntaxHighlighting.enable = true;
      enableCompletion = true;
      history.path = "${config.xdg.stateHome}/zsh/history";
      oh-my-zsh = {
        enable = true;
        theme = "robbyrussell";
        plugins = [
          "git"
          "colored-man-pages"
          "fzf"
        ];
      };
      shellAliases = {
        cat = "bat";
        cc = "claude --dangerously-skip-permissions";
        lg = "lazygit";
      };
      initContent = ''
        if (( $+commands[fnm] )); then
          eval "$(fnm env --use-on-cd --shell zsh)"
        fi

        if [ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]; then
          export SDKMAN_DIR="$HOME/.sdkman"
          source "$HOME/.sdkman/bin/sdkman-init.sh"
        fi
      '';
      loginExtra = lib.optionalString pkgs.stdenv.isDarwin ''
        source ~/.orbstack/shell/init.zsh 2>/dev/null || :
      '';
    };
  };
}
