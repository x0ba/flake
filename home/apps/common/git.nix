{
  config,
  lib,
  ...
}:
let
  cfg = config.app.git;
in
{
  options.app.git.enable = lib.mkEnableOption "Git";

  config = lib.mkIf cfg.enable {
    programs.git = {
      enable = true;
      lfs.enable = true;
      settings = {
        push.autoSetupRemote = true;
        user = {
          email = "hi@danielx.me";
          name = "Daniel Xu";
        };
      };
    };
  };
}
