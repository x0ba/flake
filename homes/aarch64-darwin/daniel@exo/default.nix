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
}:
let
  inherit (pkgs.stdenv.hostPlatform) isDarwin isLinux;
in
{
  file."Library/.ignore" = {
    enable = isDarwin;
    text = ''
      Mobile Documents/
    '';
  };

  home.sessionVariables.SSH_AUTH_SOCK = lib.optionalString isDarwin "${config.programs.gpg.homedir}/S.gpg-agent.ssh";

  skibidi = {
    desktop = {
      firefox.enable = true;
      ghostty.enable = true;
      fonts.enable = true;
    };
    user.enable = true;
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
}
