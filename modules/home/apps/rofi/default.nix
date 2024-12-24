{
  lib,
  config,
  pkgs,
  namespace,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.${namespace}.apps.rofi;
in {
  options.${namespace}.apps.rofi = {
    enable = mkEnableOption "rofi";
  };

  config = mkIf cfg.enable {
    programs.rofi = {
      enable = true;
      package = pkgs.rofi-wayland;
      font = "Inter 14";
      extraConfig.icon-theme = config.gtk.iconTheme.name;
      terminal = "ghostty";
      theme = "custom";
    };
  };
}
