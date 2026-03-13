{
  nix-homebrew = {
    enable = true;
    enableRosetta = true;
    user = "daniel";
    autoMigrate = true;
  };
  homebrew = {
    enable = true;
    onActivation.cleanup = "uninstall";
    onActivation.autoUpdate = false;
    onActivation.upgrade = false;

    brews = [
      "opencode"
      "pinentry-mac"
    ];
  };
}
