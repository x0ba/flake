{
  config,
  lib,
  ...
}:
let
  cfg = config.app.zoxide;
in
{
  options.app.zoxide.enable = lib.mkEnableOption "zoxide";

  config = lib.mkIf cfg.enable {
    programs.zoxide.enable = true;
  };
}
