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
    };
  };

  system.stateVersion = 4;
}
