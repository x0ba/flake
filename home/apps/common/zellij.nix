{
  config,
  lib,
  ...
}:
let
  cfg = config.app.zellij;
in
{
  options.app.zellij.enable = lib.mkEnableOption "Zellij";

  config = lib.mkIf cfg.enable {
    programs.zellij.enable = true;
  };
}
