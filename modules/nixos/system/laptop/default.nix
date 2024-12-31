{
  options,
  config,
  lib,
  pkgs,
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

    hardware.acpilight.enable = false;

    # handle ACPI events
    services.acpid.enable = true;

    environment.systemPackages = builtins.attrValues {inherit (pkgs) acpi powertop;};

    boot = {
      kernelModules = ["acpi_call"];
      extraModulePackages = with config.boot.kernelPackages; [
        acpi_call
        cpupower
      ];
    };

    # Enable auto-cpufreq (better than gnomes internal power manager)
    services = {
      auto-cpufreq = {
        enable = true;
        settings = {
          battery = {
            enable_thresholds = true;
            start_threshold = 70;
            stop_threshold = 80;
          };
        };
      };
      upower = {
        enable = true;
        percentageLow = 15;
        percentageCritical = 5;
        percentageAction = 3;
        criticalPowerAction = "PowerOff";
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
