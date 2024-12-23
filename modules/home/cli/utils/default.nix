{
  lib,
  config,
  pkgs,
  namespace,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  inherit (lib.${namespace}) enabled;

  cfg = config.${namespace}.cli.utils;
in {
  options.${namespace}.cli.utils = {
    enable = mkEnableOption "misc cli utils";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      dwt1-shell-color-scripts
      gcc
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
      zoxide.enable = true;
      starship.enable = true;
      direnv.enable = true;
      nix-index.enable = true;
    };
  };
}
