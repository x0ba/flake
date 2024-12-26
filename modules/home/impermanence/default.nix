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
    imports = [
      inputs.impermanence.nixosModules.home-manager.impermanence
    ];

    home.persistence."/persist/home" = {
      directories = [
        "Downloads"
        "Music"
        "Pictures"
        "Code"
        "Documents"
        "Videos"
        "Nextcloud"
        ".gnupg"
        ".mozilla/firefox"
        ".dotfiles"
        ".ssh"
        ".local/share/keyrings"
        ".local/share/atuin"
        ".local/share/nvim"
        ".local/share/zoxide"
        ".local/share/direnv"
      ];
      allowOther = true;
    };
  };
}
