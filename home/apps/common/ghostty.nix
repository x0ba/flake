{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.app.ghostty;
in
{
  options.app.ghostty.enable = lib.mkEnableOption "Ghostty";

  config = lib.mkIf cfg.enable {
    programs.ghostty =
      if pkgs.stdenv.isDarwin then
        {
          enable = true;
          package = null;
          settings = {
            font-family = "Cascadia Code";
            font-feature = "-liga";
            keybind = [
              "alt+left=esc:B"
              "alt+right=esc:F"
            ];
          };
        }
      else
        {
          enable = true;
          settings = {
            font-family = "Cascadia Code";
            font-feature = "-liga";
            window-padding-x = 8;
            window-padding-y = 8;
          };
        };

    home.sessionVariables = lib.mkIf pkgs.stdenv.isLinux {
      TERMINAL = "ghostty";
    };
  };
}
