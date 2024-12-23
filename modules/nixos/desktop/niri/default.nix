{
  options,
  config,
  pkgs,
  lib,
  inputs,
  namespace,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.desktop.niri;
in {
  options.${namespace}.desktop.niri = with types; {
    enable = mkBoolOpt false "Enable or disable the niri window manager.";
  };

  config = mkIf cfg.enable {
    programs.niri.enable = true;
    environment.systemPackages = with pkgs; [
      # file management
      nautilus
      nautilus-python
      nautilus-open-any-terminal
      wl-clipboard
      # thumbnails
      webp-pixbuf-loader
      ffmpegthumbnailer
    ];
    programs.file-roller.enable = true;
  };
}
