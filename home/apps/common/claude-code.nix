{
  config,
  lib,
  ...
}:
let
  cfg = config.app."claude-code";
in
{
  options.app."claude-code".enable = lib.mkEnableOption "Claude Code";

  config = lib.mkIf cfg.enable {
    programs.claude-code.enable = true;
  };
}
