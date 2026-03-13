{
  config,
  lib,
  ...
}:
let
  cfg = config.app.homebrewApps;
in
{
  options.app.homebrewApps.enable = lib.mkEnableOption "Homebrew GUI applications";

  config = lib.mkIf cfg.enable {
    homebrew.casks = [
      "1password"
      "antigravity"
      "balenaetcher"
      "claude"
      "cmux"
      "codex"
      "discord"
      "figma"
      "ghostty"
      "granola"
      "helium-browser"
      "iina"
      "imageoptim"
      "legcord"
      "notion"
      "notion-calendar"
      "notion-mail"
      "obsidian"
      "ollama-app"
      "orbstack"
      "raycast"
      "rectangle"
      "remnote"
      "routine"
      "shottr"
      "slack"
      "spotify"
      "thaw"
      "the-unarchiver"
      "thebrowsercompany-dia"
      "topnotch"
      "warp"
      "wispr-flow"
      "yaak"
      "yubico-authenticator"
      "zed"
      "zen"
      "zoom"
    ];
  };
}
