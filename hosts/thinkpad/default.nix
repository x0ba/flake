{
  config,
  inputs,
  pkgs,
  user,
  hostName,
  ...
}:
{
  imports = [ ./hardware-configuration.nix ];

  networking.hostName = hostName;
  time.timeZone = "America/Los_Angeles";
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "us";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.networkmanager.enable = true;

  hardware.graphics.enable = true;

  services.dbus.enable = true;
  services.fwupd.enable = true;
  services.libinput.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    jack.enable = true;
  };

  security.polkit.enable = true;
  security.rtkit.enable = true;

  programs = {
    niri = {
      enable = true;
      package = pkgs.niri;
    };
    zsh.enable = true;
  };

  services.greetd = {
    enable = true;
    settings.default_session = {
      command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --remember-user-session --cmd ${config.programs.niri.package}/bin/niri-session";
      user = "greeter";
    };
  };

  users.users = {
    ${user} = {
      isNormalUser = true;
      description = "Daniel";
      extraGroups = [
        "input"
        "networkmanager"
        "video"
        "wheel"
      ];
      shell = pkgs.zsh;
    };
  };

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = [ pkgs."xdg-desktop-portal-gtk" ];
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "hm-backup";
    extraSpecialArgs = {
      inherit inputs user hostName;
    };
    users = {
      ${user} = import ../../home/linux;
    };
  };

  system.stateVersion = "25.05";
}
