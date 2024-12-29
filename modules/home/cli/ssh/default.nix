{
  lib,
  config,
  namespace,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.${namespace}.cli.ssh;
in {
  options.${namespace}.cli.ssh = {
    enable = mkEnableOption "ssh";
  };

  config = mkIf cfg.enable {
    programs.ssh.enable = true;
  };
}
