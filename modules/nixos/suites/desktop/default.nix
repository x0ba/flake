{
  options,
  config,
  lib,
  namespace,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.suites.desktop;
in {
  options.${namespace}.suites.desktop = with types; {
    enable = mkBoolOpt false "Whether or not to enable desktop configuration.";
  };

  config = mkIf cfg.enable {
    skibidi = {
      # apps.onepassword.enable = true;
      hardware.yubikey.enable = true;
      system.virtualization.enable = true;
    };
  };
}
