{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.app.zsh;
in
{
  options.app.zsh.enable = lib.mkEnableOption "Zsh";

  config = lib.mkIf cfg.enable {
    programs.zsh = {
      enable = true;
      autosuggestion.enable = true;
      dotDir = config.home.homeDirectory;
      syntaxHighlighting.enable = true;
      enableCompletion = true;
      history.path = "${config.xdg.stateHome}/zsh/history";
      oh-my-zsh = {
        enable = true;
        theme = "robbyrussell";
        plugins = [
          "git"
          "colored-man-pages"
          "fzf"
        ];
      };
      shellAliases = {
        cat = "bat";
        cc = "claude --dangerously-skip-permissions";
        lg = "lazygit";
      };
      initContent = ''
        if (( $+commands[fnm] )); then
          eval "$(fnm env --use-on-cd --shell zsh)"
        fi

        if [ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]; then
          export SDKMAN_DIR="$HOME/.sdkman"
          source "$HOME/.sdkman/bin/sdkman-init.sh"
        fi
      '';
      loginExtra = lib.optionalString pkgs.stdenv.isDarwin ''
        source ~/.orbstack/shell/init.zsh 2>/dev/null || :
      '';
    };
  };
}
