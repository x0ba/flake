{
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    ../common/default.nix
    ../apps/common
    ../apps/linux
    inputs.noctalia.homeModules.default
  ];

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  dconf.settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";

  home.pointerCursor = {
    gtk.enable = true;
    name = "Bibata-Modern-Ice";
    package = pkgs.bibata-cursors;
    size = 24;
  };

  gtk = {
    enable = true;
    colorScheme = "dark";
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
    gtk4.extraConfig.gtk-application-prefer-dark-theme = 1;
  };

  xdg.mimeApps = {
    enable = true;
  };
}
