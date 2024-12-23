{
  lib,
  pkgs,
  namespace,
  ...
}:
with lib.${namespace};
{
  skibidi = {
    nix.enable = true;
    settings.enable = true;
    brew = {
      enable = true;
      casks = [ "prismlauncher" ];
    };
  };

  system.stateVersion = 4;
}
