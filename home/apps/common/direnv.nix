{
  config,
  lib,
  ...
}:
let
  cfg = config.app.direnv;
in
{
  options.app.direnv.enable = lib.mkEnableOption "direnv";

  config = lib.mkIf cfg.enable {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
