{
  config,
  lib,
  ...
}:
let
  cfg = config.app.carapace;
in
{
  options.app.carapace.enable = lib.mkEnableOption "Carapace";

  config = lib.mkIf cfg.enable {
    programs.carapace = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
