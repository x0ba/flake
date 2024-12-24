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
  cfg = config.${namespace}.desktop.addons.wofi;
in
{
  options.${namespace}.desktop.addons.wofi = with types; {
    enable = mkBoolOpt false "Enable or disable the wofi run launcher.";
  };

  config = mkIf cfg.enable {
    programs.wofi = {
      enable = true;
      settings = {
        width = 900;
        height = 600;
        location = "center";
        show = "drun";
        prompt = "Search...";
        filter_rate = 100;
        allow_markup = true;
        no_actions = true;
        halign = "fill";
        orientation = "vertical";
        content_halign = "fill";
        insensitive = true;
        allow_images = true;
        image_size = 35;
        gtk_dark = true;
      };
      style = # css
        ''
          window {
            margin: 5px;
            border: 5px solid #181926;
            background-color: #1e1e2e;
            border-radius: 15px;
            font-family: "JetBrainsMono";
            font-size: 14px;
          }

          #input {
            all: unset;
            min-height: 36px;
            padding: 4px 10px;
            margin: 4px;
            border: none;
            color: #cdd6f4;
            font-weight: bold;
            background-color: #181825;
            outline: none;
            border-radius: 15px;
            margin: 10px;
            margin-bottom: 2px;
          }

          #inner-box {
            margin: 4px;
            padding: 10px;
            font-weight: bold;
            border-radius: 15px;
          }

          #outer-box {
            margin: 0px;
            padding: 3px;
            border: none;
            border-radius: 15px;
            border: 5px solid #181825;
          }

          #scroll {
            margin-top: 5px;
            border: none;
            border-radius: 15px;
            margin-bottom: 5px;
          }

          #text:selected {
            color: #181825;
            margin: 0px 0px;
            border: none;
            border-radius: 15px;
          }

          #entry {
            margin: 0px 0px;
            border: none;
            border-radius: 15px;
            background-color: transparent;
          }

          #entry:selected {
            margin: 0px 0px;
            border: none;
            border-radius: 15px;
            background: #89b4fa;
            background-size: 400% 400%;
          }
        '';
    };
  };
}

