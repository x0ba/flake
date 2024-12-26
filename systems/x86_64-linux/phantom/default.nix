{ ... }:
{
  imports = [
    ./hardware.nix
  ];

  networking.hostName = "phantom";

  skibidi = {
    suites = {
      common.enable = true;
      desktop.enable = true;
    };
    user = {
      name = "daniel";
      initialPassword = "password";
    };
    system = {
      hardware_acceleration.enable = true;
      laptop.enable = true;
    };
    desktop.niri.enable = true;
  };

  system.stateVersion = "24.11";
}
