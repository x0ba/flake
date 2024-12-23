{
  options,
  config,
  pkgs,
  lib,
  namespace,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.system.virtualization;
in {
  options.${namespace}.system.virtualization = with types; {
    enable = mkBoolOpt false "Whether or not to manage virtualization settings.";
  };

  config = mkIf cfg.enable {
    virtualisation = {
      libvirtd.enable = true;
    };
    users.users."daniel".extraGroups = [
      "libvirtd"
    ];
    environment.systemPackages = with pkgs; [
      virt-manager
      virtiofsd
    ];
  };
}
