{
  lib,
  config,
  pkgs,
  inputs,
  namespace,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.${namespace}.impermanence;
in
{
  options.${namespace}.impermanence = {
    enable = mkEnableOption "impermanence";
  };

  config = mkIf cfg.enable {
    home.persistence."/persist/home" = {
      directories = [
        "Downloads"
        "Music"
        "Pictures"
        "Code"
        "Documents"
        "Videos"
        ".local/share/keyrings"
      ];
      allowOther = true;
    };
  };
}
