{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.app.niri;
in
{
  options.app.niri.enable = lib.mkEnableOption "Niri system integration";

  config = lib.mkIf cfg.enable {
    programs.niri = {
      enable = true;
      package = pkgs.niri;
    };

    services.greetd = {
      enable = true;
      settings.default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --remember-user-session --cmd ${config.programs.niri.package}/bin/niri-session";
        user = "greeter";
      };
    };
  };
}
