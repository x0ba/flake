{inputs, ...}: let
  user = "daniel@phantom";
in {
  imports = [
    ./hardware.nix
  ];

  sops.secrets.password.neededForUsers = true;

  networking.hostName = "phantom";

  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users = {
      daniel = import ../../../homes/x86_64-linux/${user};
    };
  };

  skibidi = {
    secrets.enable = true;
    impermanence.enable = true;
    suites = {
      common.enable = true;
      desktop.enable = true;
    };
    user = {
      name = "daniel";
    };
    system = {
      hardware_acceleration.enable = true;
      laptop.enable = true;
    };
    desktop.niri.enable = true;
  };

  system.stateVersion = "24.11";
}
