{
  config,
  lib,
  ...
}:
let
  cfg = config.app.gh;
in
{
  options.app.gh.enable = lib.mkEnableOption "GitHub CLI";

  config = lib.mkIf cfg.enable {
    programs.gh = {
      enable = true;
      settings = {
        git_protocol = "https";
        prompt = "enabled";
        prefer_editor_prompt = "disabled";
        aliases.co = "pr checkout";
        color_labels = "disabled";
        accessible_colors = "disabled";
        accessible_prompter = "disabled";
        spinner = "enabled";
      };
    };
  };
}
