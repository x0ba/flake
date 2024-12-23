{
  lib,
  pkgs,
  inputs,
  namespace,
  system,
  target,
  format,
  virtual,
  systems,
  config,
  ...
}: {
  imports = [
    ./hardware.nix
  ];

  networking = {
    hostName = "phantom";
    networkmanager.enable = true;
  };

  services = {
    printing.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;

  skibidi = {
    nix.enable = true;
    hardware = {
      yubikey.enable = true;
    };
    system = {
      boot.enable = true;
      hardware_acceleration.enable = true;
      locale.enable = true;
      time.enable = true;
      xkb.enable = true;
      battery.enable = true;
    };
    user = {
      name = "daniel";
      initialPassword = "password";
    };
    desktop.gnome.enable = true;
  };

  system.stateVersion = "24.11";
}
