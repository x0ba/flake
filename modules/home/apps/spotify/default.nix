{
  lib,
  pkgs,
  config,
  namespace,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  inherit (pkgs.stdenv.hostPlatform) isLinux;

  cfg = config.${namespace}.apps.spotify;
in {
  options.${namespace}.apps.spotify = {
    enable = mkEnableOption "spotify";
  };

  config = mkIf cfg.enable {
    home.persistence."/persist/home".directories =
      if isLinux
      then [
        ".config/spotify"
      ]
      else [];
    home.packages = with pkgs; [
      spotify
    ];
  };
}
