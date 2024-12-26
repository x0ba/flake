{
  options,
  config,
  lib,
  namespace,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.system.laptop;
in
{
  options.${namespace}.system.laptop = with types; {
    enable = mkBoolOpt false "Whether or not to enable laptop optimizations and utils.";
  };

  config = mkIf cfg.enable {
    # Better scheduling for CPU cycles - thanks System76!!!
    services.system76-scheduler.enable = true;

    # Enable TLP (better than gnomes internal power manager)
    services = {
      # tlp = {
      #   enable = true;
      #   settings = {
      #     CPU_BOOST_ON_AC = 1;
      #     CPU_BOOST_ON_BAT = 0;
      #     CPU_SCALING_GOVERNOR_ON_AC = "performance";
      #     CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      #     USB_DENYLIST = "046d:c52b 1050:0407";
      #   };
      # };
      auto-cpufreq.enable = true;
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
