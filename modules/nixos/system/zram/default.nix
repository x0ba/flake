{
  options,
  config,
  lib,
  namespace,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.system.zram;
in {
  options.${namespace}.system.zram = with types; {
    enable = mkBoolOpt false "Whether or not to enable zram.";
  };

  config = mkIf cfg.enable {
    zramSwap.enable = true;
  };
}
