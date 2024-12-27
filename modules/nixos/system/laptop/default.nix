{
  options,
  config,
  lib,
  namespace,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.system.laptop;
in {
  options.${namespace}.system.laptop = with types; {
    enable = mkBoolOpt false "Whether or not to enable laptop optimizations and utils.";
  };

  config = mkIf cfg.enable {
    # Better scheduling for CPU cycles - thanks System76!!!
    services.system76-scheduler.enable = true;

    # Enable TLP (better than gnomes internal power manager)
    services = {
      tlp = {
        enable = true;
        settings = {
          USB_DENYLIST = "046d:c52b 1050:0407";
        };
      };
      power-profiles-daemon.enable = false;
      thermald.enable = true;
      undervolt = {
        enable = true;
        coreOffset = -95;
        gpuOffset = -80;
        tempBat = 65;
      };
    };
  };
}
