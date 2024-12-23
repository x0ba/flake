{
  lib,
  config,
  pkgs,
  namespace,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  inherit (lib.${namespace}) enabled;
  zshPlugins = plugins: (map (plugin: rec {
      name = src.name;
      inherit (plugin) file src;
    })
    plugins);

  cfg = config.${namespace}.cli.zsh;
in {
  options.${namespace}.cli.zsh = {
    enable = mkEnableOption "zsh";
  };

  config = mkIf cfg.enable {
    programs.zsh = {
      enable = true;
      autosuggestion.enable = true;
      enableCompletion = true;
      initExtraFirst =
        # bash
        ''
          zvm_config() {
            ZVM_INIT_MODE=sourcing
            ZVM_CURSOR_STYLE_ENABLED=false
            ZVM_VI_HIGHLIGHT_BACKGROUND=black
            ZVM_VI_HIGHLIGHT_EXTRASTYLE=bold,underline
            ZVM_VI_HIGHLIGHT_FOREGROUND=white
          }
        '';
      dotDir = ".config/zsh";
      plugins = zshPlugins [
        {
          src = pkgs.zsh-vi-mode;
          file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
        }
        {
          src = pkgs.zsh-nix-shell;
          file = "share/zsh-nix-shell/nix-shell.plugin.zsh";
        }
        {
          src = pkgs.zsh-fast-syntax-highlighting;
          file = "share/zsh/site-functions/fast-syntax-highlighting.plugin.zsh";
        }
      ];
      shellAliases = {
        ls = "${pkgs.eza}/bin/eza";
        ll = "${pkgs.eza}/bin/eza -l";
        la = "${pkgs.eza}/bin/eza -a";
        lt = "${pkgs.eza}/bin/eza -T";
        lla = "${pkgs.eza}/bin/eza -la";
        llt = "${pkgs.eza}/bin/eza -lT";

        cp = "cp -i";
        mv = "mv -i";
        rm = "rm -i";
      };
      history.path = "${config.xdg.configHome}/zsh/history";
    };
  };
}
