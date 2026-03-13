{
  config,
  lib,
  ...
}:
let
  cfg = config.app.mise;
in
{
  options.app.mise.enable = lib.mkEnableOption "mise";

  config = lib.mkIf cfg.enable {
    programs.mise = {
      enable = true;
      enableZshIntegration = true;
      globalConfig.tools.node = "lts";
    };
  };
}
