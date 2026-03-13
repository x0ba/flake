{
  config,
  lib,
  ...
}:
let
  cfg = config.app."noctalia-shell";
in
{
  options.app."noctalia-shell".enable = lib.mkEnableOption "Noctalia Shell";

  config = lib.mkIf cfg.enable {
    programs.noctalia-shell = {
      enable = true;
      settings = {
        location = {
          monthBeforeDay = true;
          name = "San Diego";
        };
        colorSchemes.predefinedScheme = "Monochrome";
      };
      systemd.enable = true;
    };
  };
}
