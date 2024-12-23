{
  config,
  pkgs,
  lib,
  namespace,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.hardware.audio;
in {
  options.${namespace}.hardware.audio = with types; {
    enable = mkBoolOpt false "Whether or not to enable audio support.";
  };

  config = mkIf cfg.enable {
    services = {
      pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
      };
    };

    hardware.pulseaudio.enable = false;
  };
}
