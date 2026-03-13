{
  config,
  isDarwin,
  isLinux,
  lib,
  ...
}:
let
  cfg = config."home-config";
in
{
  imports = [ ./options.nix ];

  config = lib.mkMerge [
    (lib.mkIf cfg.cli.commonTools.enable {
      app.bat.enable = lib.mkDefault true;
      app.btop.enable = lib.mkDefault true;
      app.eza.enable = lib.mkDefault true;
      app.fd.enable = lib.mkDefault true;
      app.fzf.enable = lib.mkDefault true;
      app.htop.enable = lib.mkDefault true;
      app.tealdeer.enable = lib.mkDefault true;
      app.wget.enable = lib.mkDefault true;
    })

    (lib.mkIf cfg.cli.shell.enable {
      app.bash.enable = lib.mkDefault true;
      app.carapace.enable = lib.mkDefault true;
      app.starship.enable = lib.mkDefault true;
      app.zoxide.enable = lib.mkDefault true;
      app.zsh.enable = lib.mkDefault true;
    })

    (lib.mkIf cfg.dev.git.enable {
      app.gh.enable = lib.mkDefault true;
      app.git.enable = lib.mkDefault true;
      app."git-lfs".enable = lib.mkDefault true;
      app.gitflow.enable = lib.mkDefault true;
      app.jujutsu.enable = lib.mkDefault true;
      app.lazygit.enable = lib.mkDefault true;
    })

    (lib.mkIf cfg.dev.devTools.enable {
      app.autossh.enable = lib.mkDefault true;
      app.cascadia-code.enable = lib.mkDefault true;
      app."claude-code".enable = lib.mkDefault true;
      app.codex.enable = lib.mkDefault true;
      app.direnv.enable = lib.mkDefault true;
      app.helix.enable = lib.mkDefault true;
      app.mise.enable = lib.mkDefault true;
      app.poppler.enable = lib.mkDefault true;
      app."pre-commit".enable = lib.mkDefault true;
      app.pyenv.enable = lib.mkDefault true;
      app.stow.enable = lib.mkDefault true;
      app.tmux.enable = lib.mkDefault true;
      app.vim.enable = lib.mkDefault true;
      app.yazi.enable = lib.mkDefault true;
      app.zellij.enable = lib.mkDefault true;
    })

    (lib.mkIf cfg.dev.vscode.enable {
      app.vscode.enable = lib.mkDefault true;
    })

    (
      if isDarwin && cfg.dev.zed.enable then
        {
          app."zed-editor".enable = lib.mkDefault true;
        }
      else
        { }
    )

    (lib.mkIf cfg.gui.firefox.enable {
      app.firefox.enable = lib.mkDefault true;
    })

    (lib.mkIf cfg.gui.ghostty.enable {
      app.ghostty.enable = lib.mkDefault true;
    })

    (
      if isDarwin && cfg.gui.karabiner.enable then
        {
          app.karabiner.enable = lib.mkDefault true;
        }
      else
        { }
    )

    (
      if isLinux && cfg.gui.social.enable then
        {
          app.discord.enable = lib.mkDefault true;
          app.slack.enable = lib.mkDefault true;
        }
      else
        { }
    )

    (
      if isLinux && cfg.gui.utils.enable then
        {
          app.evince.enable = lib.mkDefault true;
          app."file-roller".enable = lib.mkDefault true;
          app.loupe.enable = lib.mkDefault true;
          app.mpv.enable = lib.mkDefault true;
          app.nautilus.enable = lib.mkDefault true;
          app.obsidian.enable = lib.mkDefault true;
          app.pavucontrol.enable = lib.mkDefault true;
          app.spotify.enable = lib.mkDefault true;
        }
      else
        { }
    )

    (
      if isLinux && cfg.desktop.niri.enable then
        {
          app.niri.enable = lib.mkDefault true;
          app."noctalia-shell".enable = lib.mkDefault true;
        }
      else
        { }
    )

    (lib.mkIf cfg.security.yubikey.enable {
      app."yubikey-manager".enable = lib.mkDefault true;
      app."yubikey-personalization".enable = lib.mkDefault true;
    })
  ];
}
