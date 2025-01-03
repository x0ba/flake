{
  lib,
  config,
  inputs,
  pkgs,
  namespace,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  inherit (pkgs.stdenv) isDarwin isLinux;

  cfg = config.${namespace}.apps.discord;
  css =
    # css
    ''
      @import url('//fonts.googleapis.com/css2?family=IBM+Plex+Mono:ital,wght@0,400;0,500;0,600;0,700;1,400;1,500;1,600;1,700&family=IBM+Plex+Sans:ital,wght@0,400;0,500;0,600;0,700;1,400;1,500;1,600;1,700&display=swap');

      :root {
        --font-primary: "Inter", sans-serif;
        --font-headline: "Inter", sans-serif;
        --font-display: "Inter", sans-serif;
        --font-code: "BerkeleyMono Nerd Font", mono;
      }

      @media (max-width: 1024px) {
        nav[aria-label="Servers sidebar"] {
          display: none;
        }

        .platform-osx div[class^="base_"]>div[class^="content_"]>div[class^="sidebar_"],
        .platform-osx div[class^="base_"]>div[class^="content_"]>main[class^="container_"],
        .platform-osx div[class^="base_"]>div[class^="content_"]>div[class^="chat_"] {
          padding-top: 32px !important;
        }
      }

      @media (max-width: 768px) {
        div[class^="base_"]>div[class^="content_"]>div[class^="sidebar_"] {
          display: none;
        }
      }
    '';
in {
  options.${namespace}.apps.discord = {
    enable = mkEnableOption "discord";
  };

  config = mkIf cfg.enable {
    home.packages = [(pkgs.discord.override {withOpenASAR = true;})];

    home.activation.discordSettings = let
      json = pkgs.writeTextFile {
        name = "discord-settings.json";
        text = lib.generators.toJSON {} {
          DANGEROUS_ENABLE_DEVTOOLS_ONLY_ENABLE_IF_YOU_KNOW_WHAT_YOURE_DOING = true;
          MIN_WIDTH = 0;
          MIN_HEIGHT = 0;
          openasar = {
            inherit css;
            setup = true;
          };
          trayBalloonShown = false;
          SKIP_HOST_UPDATE = true;
        };
      };
      path =
        if isLinux
        then "${config.xdg.configHome}/discord/settings.json"
        else if isDarwin
        then "${config.home.homeDirectory}/Library/Application Support/discord/settings.json"
        else throw "unsupported platform";
    in
      # gets written as a file after the writeBoundary to keep it mutable
      inputs.home-manager.lib.hm.dag.entryAfter ["writeBoundary"] # bash
      
      ''
        mkdir -p "$(dirname "${path}")"
        cp -f "${json}" "${path}"
      '';
  };
}
