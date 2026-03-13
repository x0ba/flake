{
  config,
  lib,
  ...
}:
let
  cfg = config.app.pyenv;
in
{
  options.app.pyenv.enable = lib.mkEnableOption "pyenv";

  config = lib.mkIf cfg.enable {
    programs.pyenv = {
      enable = true;
      enableZshIntegration = true;
      rootDirectory = config.home.homeDirectory + "/.pyenv";
    };
  };
}
