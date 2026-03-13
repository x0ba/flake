{ lib, ... }:
let
  mkEnable = lib.mkEnableOption;
in
{
  options = {
    "home-config" = {
      cli = {
        commonTools.enable = mkEnable "common CLI tools";
        shell.enable = mkEnable "shell tooling";
      };

      dev = {
        git.enable = mkEnable "Git tooling";
        devTools.enable = mkEnable "developer tools";
        vscode.enable = mkEnable "VS Code";
        zed.enable = mkEnable "Zed";
      };

      gui = {
        firefox.enable = mkEnable "Firefox";
        ghostty.enable = mkEnable "Ghostty";
        karabiner.enable = mkEnable "Karabiner";
        social.enable = mkEnable "social apps";
        utils.enable = mkEnable "desktop utility apps";
      };

      desktop.niri.enable = mkEnable "Niri desktop integration";

      security = {
        onepassword.enable = mkEnable "1Password";
        yubikey.enable = mkEnable "YubiKey tooling";
      };

      system.homebrewApps.enable = mkEnable "Homebrew GUI apps";
    };
  };
}
