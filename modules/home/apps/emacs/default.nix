{
  lib,
  pkgs,
  config,
  namespace,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.${namespace}.apps.emacs;

  inherit (pkgs.stdenv.hostPlatform) isLinux isDarwin;
in {
  options.${namespace}.apps.emacs = {
    enable = mkEnableOption "emacs";
  };

  config = mkIf cfg.enable {
    services.emacs = {
      enable = isLinux;
    };
    programs.emacs = {
      enable = true;
      package =
        if isDarwin
        then pkgs.emacs-macport
        else pkgs.emacs29-pgtk;
      extraPackages = epkgs: [epkgs.vterm];
    };
    home.packages = with pkgs; [
      binutils
      ## Emacs itself
      binutils # native-comp needs 'as', provided by this
      cmake

      ## Doom dependencies
      git
      ripgrep
      gnutls # for TLS connectivity

      ## Optional dependencies
      fd # faster projectile indexing
      imagemagick # for image-dired
      zstd # for undo-fu-session/undo-tree compression

      ## Module dependencies
      # :email mu4e
      mu
      isync
      # :checkers spell
      (aspellWithDicts (ds: with ds; [en en-computers en-science]))
      # :tools editorconfig
      editorconfig-core-c # per-project style config
      # :tools lookup & :lang org +roam
      sqlite
      # :lang cc
      clang-tools
      # :lang latex & :lang org (latex previews)
      texlive.combined.scheme-medium
      # :lang beancount
      beancount
      fava
      # :lang nix
      age
    ];
  };
}
