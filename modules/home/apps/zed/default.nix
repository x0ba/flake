{
  lib,
  pkgs,
  config,
  namespace,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.${namespace}.apps.zed;
in
{
  options.${namespace}.apps.zed = {
    enable = mkEnableOption "zed";
  };

  config = mkIf cfg.enable {
    programs.zed-editor = {
      enable = true;
      extensions = [
        "catppuccin"
        "nix"
      ];
      userSettings = {
        vim_mode = true;
        telemetry = {
          metrics = false;
          diagnostics = false;
        };
        ui_font_size = 16;
        ui_font_family = "Inter";
        buffer_font_family = "BerkeleyMono Nerd Font";
        terminal = {
          font_family = "BerkeleyMono Nerd Font";
        };
        buffer_font_size = 16;
        theme = {
          mode = "system";
          light = "Catppuccin Latte";
          dark = "Catppuccin Mocha";
        };
        languages.Nix.language_servers = [
          "nil"
          "!nixd"
        ];
        lsp.nixd.settings.diagnostic.suppress = [ "sema-extra-with" ];
      };
    };
  };
}
