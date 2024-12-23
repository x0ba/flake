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

  cfg = config.${namespace}.desktop.ghostty;
in {
  options.${namespace}.desktop.ghostty = {
    enable = mkEnableOption "ghostty";
  };

  config = mkIf cfg.enable {
    home.packages = [
      inputs.ghostty.packages.x86_64-linux.default
    ];
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
