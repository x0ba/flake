{
  options,
  config,
  lib,
  pkgs,
  inputs,
  namespace,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.desktop.addons.mako;
in
{
  options.${namespace}.desktop.addons.mako = with types; {
    enable = mkBoolOpt false "Enable or disable mako";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      mako
    ];

    services.mako = {
      enable = true;
      backgroundColor = "#1e1e2e";
      textColor = "#cdd6f4";
      borderColor = "#89b4fa";
      progressColor = "#313244";
      extraConfig = ''
        [urgency=high]
        border-color=#fab387
      '';
    };
  };
}

