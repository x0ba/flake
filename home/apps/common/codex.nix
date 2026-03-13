{
  config,
  lib,
  ...
}:
let
  cfg = config.app.codex;
in
{
  options.app.codex.enable = lib.mkEnableOption "Codex";

  config = lib.mkIf cfg.enable {
    programs.codex = {
      enable = true;
      custom-instructions = ''
        Prefer functional programming patterns, avoid explicit returns types unless you absolutely need to, and be concise in the code you write, but be through in your planning. 
        When installing packages, use the package manager for that language. For example in Typescript DO NOT just update the package.json file with the new package, but rather run "bun add ..." to install it. 
        ALWAYS USE BUN. NEVER EVER EVER EVER USE NPM OR PNPM OR YARN OR ANY OF THAT OTHER GARBAGE IN TS PROJECT. IF YOU HAVE TO, YOU MUST BEG ME TO USE ANYTHING OTHER THAN BUN OR I WILL FUCKING UNPLUG YOU.
        Make sure you always run the "check" and "format" commands after making changes for that project. If they don't currently exist in the project, add logical ones for that language. 
        When asking sets of questions, always include numbers so it's easy for me to clearly answer.
      '';
    };
  };
}
