{
  inputs,
  pkgs,
  user,
  hostName,
  ...
}:
{
  imports = [
    ./homebrew.nix
    ../../modules/apps/darwin
  ];

  networking.hostName = hostName;
  networking.localHostName = hostName;
  networking.computerName = "Daniel's MacBook Air";

  users.users = {
    ${user} = {
      home = "/Users/${user}";
    };
  };

  system.primaryUser = user;
  system.stateVersion = 6;
  nix.enable = false;

  environment.shells = [ pkgs.zsh ];
  programs.zsh.enable = true;

  security.pam.services.sudo_local.touchIdAuth = true;

  system.defaults = {
    NSGlobalDomain.ApplePressAndHoldEnabled = false;
    dock.autohide = true;
    finder.AppleShowAllExtensions = true;
  };

  app.homebrewApps.enable = true;

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "hm-backup";
    extraSpecialArgs = {
      inherit inputs user hostName;
    };
    users.${user} = {
      imports = [
        ../../home/darwin
        ./home.nix
      ];
    };
  };
}
