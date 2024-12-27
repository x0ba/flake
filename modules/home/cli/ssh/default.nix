{
  lib,
  pkgs,
  config,
  namespace,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  inherit (pkgs.stdenv.hostPlatform) isLinux;

  cfg = config.${namespace}.cli.ssh;
in {
  options.${namespace}.cli.ssh = {
    enable = mkEnableOption "ssh";
  };

  config = mkIf cfg.enable {
    home.persistence."/persist/home".directories =
      if isLinux
      then [
        ".ssh"
      ]
      else [];
    programs.ssh.enable = true;
  };
}
