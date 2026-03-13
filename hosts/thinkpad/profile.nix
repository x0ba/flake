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
    };

    gui = {
      firefox.enable = true;
      ghostty.enable = true;
      social.enable = true;
      utils.enable = true;
    };

    desktop.niri.enable = true;

    security = {
      onepassword.enable = true;
      yubikey.enable = true;
    };
  };
}
