{
  ...
}: {
  imports = [
    ./hardware.nix
  ];

  networking.hostName = "phantom";

  security.rtkit.enable = true;

  skibidi = {
    nix.enable = true;
    apps = {
      onepassword.enable = true;
    };
    hardware = {
      yubikey.enable = true;
      audio.enable = true;
      networking.enable = true;
      printing.enable = true;
    };
    system = {
      boot.enable = true;
      hardware_acceleration.enable = true;
      ld.enable = true;
      locale.enable = true;
      time.enable = true;
      xkb.enable = true;
      laptop.enable = true;
      virtualization.enable = true;
    };
    user = {
      name = "daniel";
      initialPassword = "password";
    };
    desktop.gnome.enable = true;
  };

  system.stateVersion = "24.11";
}
