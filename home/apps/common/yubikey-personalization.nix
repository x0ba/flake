{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.app."yubikey-personalization";
in
{
  options.app."yubikey-personalization".enable = lib.mkEnableOption "YubiKey Personalization";

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs."yubikey-personalization" ];
  };
}
