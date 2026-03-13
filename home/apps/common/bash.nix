{
  config,
  lib,
  ...
}:
let
  cfg = config.app.bash;
in
{
  options.app.bash.enable = lib.mkEnableOption "Bash";

  config = lib.mkIf cfg.enable {
    programs.bash.enable = true;
  };
}
