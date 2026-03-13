{
  config,
  lib,
  ...
}:
let
  cfg = config.app."zed-editor";
in
{
  options.app."zed-editor".enable = lib.mkEnableOption "Zed";

  config = lib.mkIf cfg.enable {
    programs.zed-editor = {
      enable = true;
      package = null;
      mutableUserSettings = false;
      userSettings = {
        buffer_font_family = "Cascadia Code";
        vim_mode = true;
        icon_theme = {
          mode = "dark";
          light = "Zed (Default)";
          dark = "Zed (Default)";
        };
        ui_font_size = 16;
        buffer_font_size = 13.0;
        theme = {
          mode = "dark";
          light = "Ayu Light";
          dark = "Ayu Dark";
        };
      };
    };
  };
}
