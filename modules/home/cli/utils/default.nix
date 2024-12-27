{
  lib,
  config,
  pkgs,
  namespace,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  inherit (pkgs.stdenv.hostPlatform) isLinux;

  cfg = config.${namespace}.cli.utils;
in {
  options.${namespace}.cli.utils = {
    enable = mkEnableOption "misc cli utils";
  };

  config = mkIf cfg.enable {
    home.persistence."/persist/home".directories =
      if isLinux
      then [
        ".local/state/syncthing"
        ".local/share/atuin"
        ".local/share/zoxide"
        ".local/share/direnv"
        ".cache/tealdeer"
      ]
      else [];
    home.packages = with pkgs; [
      dwt1-shell-color-scripts
      htop
      gocryptfs
      gh
      fd
      ripgrep
      file
      ffmpeg
      manix
      just
      yt-dlp
    ];
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
        settings = builtins.fromTOML (builtins.readFile ./starship/config.toml);
      };
      direnv = {
        enable = true;
        nix-direnv.enable = true;
      };
      nix-index.enable = true;
    };
  };
}
