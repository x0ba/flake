{
  options,
  config,
  pkgs,
  lib,
  namespace,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.hardware.yubikey;
in
{
  options.${namespace}.hardware.yubikey = with types; {
    enable = mkBoolOpt false "Whether or not to enable yubikey support.";
  };

  config = mkIf cfg.enable {
    services = {
      udev.packages = [ pkgs.yubikey-personalization ];
      pcscd.enable = true;
    };

    hardware.gpgSmartcards.enable = true;
  };
}
