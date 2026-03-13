{
  config,
  lib,
  ...
}:
let
  cfg = config.app.fzf;
in
{
  options.app.fzf.enable = lib.mkEnableOption "fzf";

  config = lib.mkIf cfg.enable {
    programs.fzf.enable = true;
  };
}
