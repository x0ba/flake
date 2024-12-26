{
  pkgs,
  home,
  config,
  ...
}:
{
  home.packages = with pkgs; [
    nextcloud-client
    rnote
    obsidian
    calibre
    pika-backup
    spotify
    thunderbird
    powertop
  ];
  skibidi = {
    impermanence.enable = true;
    desktop = {
      # gnome.enable = true;
      niri.enable = true;
      fonts.enable = true;
      gtk.enable = true;
    };
    apps = {
      firefox.enable = true;
      chromium.enable = true;
      discord.enable = true;
      ghostty.enable = true;
      kitty.enable = true;
      mpv.enable = true;
      xdg.enable = true;
      vscode.enable = true;
      zed.enable = true;
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
