{
  lib,
  config,
  inputs,
  pkgs,
  namespace,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  inherit (lib.${namespace}) enabled;
  inherit (pkgs.stdenv.hostPlatform) isDarwin isLinux;

  cfg = config.${namespace}.apps.ghostty;
in {
  options.${namespace}.apps.ghostty = {
    enable = mkEnableOption "ghostty";
  };

  config = mkIf cfg.enable {
    home.packages = (
      []
      ++ lib.optionals isLinux [
        inputs.ghostty.packages.x86_64-linux.default
      ]
    );
    programs.ghostty = {
      enable = true;
      settings = {
        font-size = 13;
        font-family = "Rec Mono Duotone";

        theme = "catppuccin-mocha";

        window-padding-x = "7";
        window-padding-y = "7";

        macos-titlebar-style = "tabs";

        window-theme = "dark";
        macos-option-as-alt = true;
      };
    };
  };
}