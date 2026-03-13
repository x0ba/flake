{
  config,
  lib,
  ...
}:
let
  cfg = config.app.yazi;
in
{
  options.app.yazi.enable = lib.mkEnableOption "Yazi";

  config = lib.mkIf cfg.enable {
    programs.yazi = {
      enable = true;
      shellWrapperName = "yy";
    };
  };
}
