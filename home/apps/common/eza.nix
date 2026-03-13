{
  config,
  lib,
  ...
}:
let
  cfg = config.app.eza;
in
{
  options.app.eza.enable = lib.mkEnableOption "eza";

  config = lib.mkIf cfg.enable {
    programs.eza.enable = true;
  };
}
