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
{
  skibidi = {
    desktop = {
      gnome.enable = true;
      firefox.enable = true;
    };
    user.enable = true;
    cli = {
      home-manager.enable = true;
      zsh.enable = true;
      utils.enable = true;
      neovim.enable = true;
      git.enable = true;
    };
  };
}
