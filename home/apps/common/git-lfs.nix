{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.app."git-lfs";
in
{
  options.app."git-lfs".enable = lib.mkEnableOption "Git LFS";

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs."git-lfs" ];
  };
}
