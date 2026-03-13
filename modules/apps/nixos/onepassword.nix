{
  config,
  lib,
  user,
  ...
}:
let
  cfg = config.app.onepassword;
in
{
  options.app.onepassword.enable = lib.mkEnableOption "1Password";

  config = lib.mkIf cfg.enable {
    programs._1password.enable = true;
    programs._1password-gui = {
      enable = true;
      polkitPolicyOwners = [ user ];
    };
  };
}
