{
  config,
  lib,
  ...
}:
let
  cfg = config.app.jujutsu;
in
{
  options.app.jujutsu.enable = lib.mkEnableOption "Jujutsu";

  config = lib.mkIf cfg.enable {
    programs.jujutsu = {
      enable = true;
      settings = {
        user = {
          name = "Daniel Xu";
          email = "hi@danielx.me";
        };
        remotes.origin.auto-track-bookmarks = "*";
      };
    };
  };
}
