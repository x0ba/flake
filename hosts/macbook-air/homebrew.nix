{
  homebrew = {
    enable = true;
    onActivation.cleanup = "uninstall";
    onActivation.autoUpdate = false;
    onActivation.upgrade = false;

    brews = [
      "opencode"
      "pinentry-mac"
    ];

    casks = [
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
