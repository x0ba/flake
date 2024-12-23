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
  home.packages = with pkgs; [
    nextcloud-client
    rnote
    obsidian
    calibre
    thunderbird
  ];
  skibidi = {
    desktop = {
      gnome.enable = true;
      firefox.enable = true;
      ghostty.enable = true;
      fonts.enable = true;
      mpv.enable = true;
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
