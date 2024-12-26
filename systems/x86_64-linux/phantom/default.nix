{ ... }:
{
  imports = [
    ./hardware.nix
  ];

  networking.hostName = "phantom";

  home-manager = {
    users = {
      # Import your home-manager configuration
      daniel = import "../../../homes/x86_64-linux/daniel@phantom";
    };
  };

  skibidi = {
    impermanence.enable = true;
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
