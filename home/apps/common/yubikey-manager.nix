{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.app."yubikey-manager";
in
{
  options.app."yubikey-manager".enable = lib.mkEnableOption "YubiKey Manager";

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.yubikey-manager ];
  };
}
