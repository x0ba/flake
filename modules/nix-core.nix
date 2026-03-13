{
  self,
  lib,
  pkgs,
  ...
}:
{
  nix = lib.mkIf (!pkgs.stdenv.isDarwin) {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      auto-optimise-store = true;
      warn-dirty = false;
      extra-substituters = [
        "https://nix-community.cachix.org"
      ];
      extra-trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
  };

  nixpkgs.config.allowUnfree = true;

  system.configurationRevision = lib.mkIf (self ? rev || self ? dirtyRev) (
    if self ? rev then self.rev else self.dirtyRev
  );
}
