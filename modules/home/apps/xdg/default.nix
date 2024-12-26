{
  lib,
  config,
  pkgs,
  namespace,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;

  inherit (pkgs.stdenv.hostPlatform) isDarwin isLinux;
  inherit (config.xdg)
    cacheHome
    configHome
    dataHome
    stateHome
    ;
  inherit (config.home) homeDirectory sessionVariables;

  cfg = config.${namespace}.apps.xdg;
in
{
  options.${namespace}.apps.xdg = {
    enable = mkEnableOption "xdg";
  };

  config = mkIf cfg.enable {
    home = {
      sessionVariables = {
        AZURE_CONFIG_DIR = "${configHome}/azure";
        BUNDLE_USER_CACHE = "${cacheHome}/bundle";
        BUNDLE_USER_CONFIG = "${configHome}/bundle";
        BUNDLE_USER_PLUGIN = "${dataHome}/bundle";
        CARGO_HOME = "${dataHome}/cargo";
        CUDA_CACHE_PATH = "${dataHome}/nv";
        DENO_INSTALL_ROOT = "${dataHome}/deno";
        DOCKER_CONFIG = "${configHome}/docker";
        ELM_HOME = "${dataHome}/elm";
        GEM_HOME = "${dataHome}/gem";
        GEM_SPEC_CACHE = "${cacheHome}/gem";
        GOPATH = "${dataHome}/go";
        GRADLE_USER_HOME = "${dataHome}/gradle";
        HISTFILE = "${stateHome}/bash/history";
        IPYTHONDIR = "${configHome}/ipython";
        LESSHISTFILE = "${stateHome}/less_history";
        MC_CONFIG_DIR = "${configHome}/mc";
        NODE_REPL_HISTORY = "${stateHome}/node_repl_history";
        NPM_CONFIG_USERCONFIG = "${configHome}/npm/npmrc";
        RUSTUP_HOME = "${dataHome}/rustup";
        SQLITE_HISTORY = "${stateHome}/sqlite_history";
        STACK_ROOT = "${dataHome}/stack";
        W3M_DIR = "${dataHome}/w3m";
        WAKATIME_HOME = "${dataHome}/wakatime";
        WINEPREFIX = "${dataHome}/wine";
      };
      sessionPath =
        [
          "$HOME/.local/bin"
          "${dataHome}/krew/bin"
          "${sessionVariables.GOPATH}/bin"
          "${sessionVariables.CARGO_HOME}/bin"
          "${sessionVariables.DENO_INSTALL_ROOT}/bin"
        ]
        ++ (lib.optionals isDarwin [
          # fix `nix profile` not being in PATH on macOS
          "${stateHome}/nix/profile/bin"
        ]);
    };

    xdg = {
      enable = true;
      userDirs.enable = isLinux;
      cacheHome = "${homeDirectory}/.cache";
      configHome = "${homeDirectory}/.config";
      dataHome = "${homeDirectory}/.local/share";
      stateHome = "${homeDirectory}/.local/state";
      mimeApps = {
        enable = isLinux;
        defaultApplications = lib.genAttrs [
          "inode/directory"
          "application/gzip"
          "application/vnd.rar"
          "application/x-7z-compressed"
          "application/x-bzip"
          "application/x-bzip2"
          "application/x-compressed-tar"
          "application/x-tar"
          "application/zip"
        ] (_: "nautilus.desktop;org.gnome.Nautilus.desktop");
      };
    };
  };
}
