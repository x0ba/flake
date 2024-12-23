{
  lib,
  pkgs,
  inputs,
  namespace,
  home,
  target,
  format,
  virtual,
  host,
  config,
  ...
}: {
  home.file."Library/.ignore" = {
    enable = true;
    text = ''
      Mobile Documents/
    '';
  };

  home.sessionVariables.SSH_AUTH_SOCK = "${config.programs.gpg.homedir}/S.gpg-agent.ssh";

  skibidi = {
    desktop = {
      ghostty.enable = true;
      fonts.enable = true;
    };
    user = {
      enable = true;
      name = "daniel";
    };
    cli = {
      home-manager.enable = true;
      zsh.enable = true;
      utils.enable = true;
      neovim.enable = true;
      git.enable = true;
      yazi.enable = true;
      gpg.enable = true;
    };
  };

  home.stateVersion = "23.11";
}
