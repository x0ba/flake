{ ... }:
{
  "home-config" = {
    cli = {
      commonTools.enable = true;
      shell.enable = true;
    };

    dev = {
      git.enable = true;
      devTools.enable = true;
      vscode.enable = true;
      zed.enable = true;
    };

    gui = {
      ghostty.enable = true;
      karabiner.enable = true;
    };

    security.yubikey.enable = true;

    system.homebrewApps.enable = true;
  };
}
