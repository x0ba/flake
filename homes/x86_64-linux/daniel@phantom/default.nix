{
  pkgs,
  home,
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
  nixpkgs.config.allowUnfree = true;
  skibidi = {
    desktop = {
      # gnome.enable = true;
      niri.enable = true;
      fonts.enable = true;
      gtk.enable = true;
    };
    apps = {
      firefox.enable = true;
      discord.enable = true;
      ghostty.enable = true;
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
