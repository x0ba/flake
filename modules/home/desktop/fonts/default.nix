{
  lib,
  config,
  pkgs,
  namespace,
  ...
}: let
  inherit (pkgs.stdenv) isLinux;
  inherit (lib) mkEnableOption mkIf;

  cfg = config.${namespace}.desktop.fonts;
in {
  options.${namespace}.desktop.fonts = {
    enable = mkEnableOption "fonts";
  };

  config = mkIf cfg.enable {
    fonts.fontconfig = {
      enable = isLinux;
      defaultFonts = {
        sansSerif = ["Inter"];
        serif = ["IBM Plex Serif"];
        monospace = ["JetBrainsMono Nerd Font"];
        emoji = ["Twitter Color Emoji"];
      };
    };
    home.packages = with pkgs; [
      nerd-fonts.caskaydia-cove
      nerd-fonts.blex-mono
      nerd-fonts.intone-mono
      nerd-fonts.jetbrains-mono
      nerd-fonts.monaspace
      nerd-fonts.symbols-only
      nerd-fonts.victor-mono
      ibm-plex
      inter
      monaspace
      twitter-color-emoji
      recursive
    ];
  };
}
