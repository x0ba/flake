{
  lib,
  config,
  pkgs,
  namespace,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.${namespace}.cli.utils;
in {
  options.${namespace}.cli.utils = {
    enable = mkEnableOption "misc cli utils";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      dwt1-shell-color-scripts
      btop
      htop
      lazygit
      comma
      gh
      fd
      ripgrep
      file
      ffmpeg
      just
      yt-dlp
    ];
    programs = {
      fzf.enable = true;
      atuin.enable = true;
      zoxide.enable = true;
      starship.enable = true;
      direnv = {
        enable = true;
        nix-direnv.enable = true;
      };
      nix-index.enable = true;
    };
  };
}
