{
  config,
  lib,
  ...
}:
let
  cfg = config.app.bat;
in
{
  options.app.bat.enable = lib.mkEnableOption "bat";

  config = lib.mkIf cfg.enable {
    programs.bat.enable = true;
  };
}
