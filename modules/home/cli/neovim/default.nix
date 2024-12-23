{
  lib,
  pkgs,
  config,
  namespace,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  inherit (lib.${namespace}) enabled;

  cfg = config.${namespace}.cli.neovim;
in
{
  options.${namespace}.cli.neovim = {
    enable = mkEnableOption "neovim";
  };

  config = mkIf cfg.enable { 
    programs.neovim = enabled; 
    home = {
      sessionVariables = {
        EDITOR = "nvim";
        SUDO_EDITOR = "nvim";
        VISUAL = "nvim";
      };
      shellAliases = {
        vi = "nvim";
        vim = "nvim";
        vimdiff = "nvim -d";
      };
    };
  };
}
