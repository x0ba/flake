# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "nvme" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.luks.devices."luks-4d050c2c-cfd7-4a53-b0c7-f075ddd23276".device = "/dev/disk/by-uuid/4d050c2c-cfd7-4a53-b0c7-f075ddd23276";
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/1dddc7ca-b5a3-4bf5-8fd4-78d8b5dffe69";
      fsType = "ext4";
    };

  boot.initrd.luks.devices."luks-817e407a-e9d0-4f59-b7a2-5c6683a68de2".device = "/dev/disk/by-uuid/817e407a-e9d0-4f59-b7a2-5c6683a68de2";

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/F212-146B";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/7b6c23ea-ccd4-4480-a6ef-55e3d21300ba"; }
    ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp3s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}


