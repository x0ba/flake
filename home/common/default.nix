{
  pkgs,
  user,
  ...
}:
{
  home = {
    username = user;
    homeDirectory = if pkgs.stdenv.isDarwin then "/Users/${user}" else "/home/${user}";
    stateVersion = "25.05";

    sessionPath = [
      "$HOME/.bun/bin"
      "$HOME/.local/bin"
      "$HOME/bin"
    ];

    sessionVariables = {
      BUN_INSTALL = "$HOME/.bun";
      EDITOR = "vim";
      VISUAL = "vim";
    };
  };

  xdg.enable = true;

  programs.home-manager.enable = true;
}
