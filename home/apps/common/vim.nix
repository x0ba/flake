{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.app.vim;
in
{
  options.app.vim.enable = lib.mkEnableOption "Vim";

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.vim ];
  };
}
