{
  options,
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.suites.common;
in
{
  options.${namespace}.suites.common = with types; {
    enable = mkBoolOpt false "Whether or not to enable common configuration.";
  };

  config = mkIf cfg.enable {

    skibidi = {
      nix.enable = true;

      hardware = {
        audio.enable = true;
        networking.enable = true;
      };

      services = {
        printing.enable = true;
      };

      system = {
        boot.enable = true;
        ld.enable = true;
        locale.enable = true;
        time.enable = true;
        xkb.enable = true;
      };
    };
  };
}
