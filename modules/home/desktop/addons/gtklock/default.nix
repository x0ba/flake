{
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.desktop.addons.gtklock;
in
{
  options.${namespace}.desktop.addons.gtklock = with types; {
    enable = mkBoolOpt false "Enable or disable the gtklock screen locker.";
  };

  config = mkIf cfg.enable {
    home.packages = [pkgs.gtklock];

    xdg.configFile."gtklock/style.css".text = ''
      window {
         background-size: cover;
         background-repeat: no-repeat;
         background-position: center;
         background-color: #1e1e2e;
      }

      clock-label {
          color: #cdd6f4;
      }
    '';
  };
}

