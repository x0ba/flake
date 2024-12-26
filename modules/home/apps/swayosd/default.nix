{
  lib,
  config,
  namespace,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.${namespace}.apps.swayosd;
in
{
  options.${namespace}.apps.swayosd = {
    enable = mkEnableOption "swayosd";
  };

  config = mkIf cfg.enable {
    services.swayosd.enable = true;
  };
}
