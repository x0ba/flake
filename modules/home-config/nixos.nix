{
  config,
  lib,
  ...
}:
let
  cfg = config."home-config";
in
{
  imports = [ ./options.nix ];

  config = lib.mkMerge [
    (lib.mkIf cfg.desktop.niri.enable {
      app.niri.enable = lib.mkDefault true;
    })

    (lib.mkIf cfg.security.onepassword.enable {
      app.onepassword.enable = lib.mkDefault true;
    })
  ];
}
