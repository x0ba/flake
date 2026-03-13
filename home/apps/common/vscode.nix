{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.app.vscode;

  vscodeExtension =
    publisher: name: builtins.getAttr name (builtins.getAttr publisher pkgs.vscode-extensions);
  marketplaceExtension =
    publisher: name:
    builtins.getAttr name (
      builtins.getAttr publisher
        inputs.nix-vscode-extensions.extensions.${pkgs.stdenv.hostPlatform.system}."vscode-marketplace"
    );

  packagedExtensions = map ({ publisher, name }: vscodeExtension publisher name) [
    {
      publisher = "astro-build";
      name = "astro-vscode";
    }
    {
      publisher = "bbenoist";
      name = "nix";
    }
    {
      publisher = "bradlc";
      name = "vscode-tailwindcss";
    }
    {
      publisher = "christian-kohler";
      name = "npm-intellisense";
    }
    {
      publisher = "dbaeumer";
      name = "vscode-eslint";
    }
    {
      publisher = "esbenp";
      name = "prettier-vscode";
    }
    {
      publisher = "leonardssh";
      name = "vscord";
    }
    {
      publisher = "mikestead";
      name = "dotenv";
    }
    {
      publisher = "ms-azuretools";
      name = "vscode-containers";
    }
    {
      publisher = "ms-python";
      name = "debugpy";
    }
    {
      publisher = "ms-python";
      name = "python";
    }
    {
      publisher = "ms-python";
      name = "vscode-pylance";
    }
    {
      publisher = "ms-vscode-remote";
      name = "remote-ssh";
    }
    {
      publisher = "ms-vscode-remote";
      name = "remote-ssh-edit";
    }
    {
      publisher = "ms-vscode";
      name = "remote-explorer";
    }
    {
      publisher = "ms-vsliveshare";
      name = "vsliveshare";
    }
    {
      publisher = "pkief";
      name = "material-icon-theme";
    }
    {
      publisher = "redhat";
      name = "java";
    }
    {
      publisher = "vscjava";
      name = "vscode-gradle";
    }
    {
      publisher = "vscjava";
      name = "vscode-java-debug";
    }
    {
      publisher = "vscjava";
      name = "vscode-java-dependency";
    }
    {
      publisher = "vscjava";
      name = "vscode-java-pack";
    }
    {
      publisher = "vscjava";
      name = "vscode-java-test";
    }
    {
      publisher = "vscjava";
      name = "vscode-maven";
    }
    {
      publisher = "vscodevim";
      name = "vim";
    }
    {
      publisher = "yoavbls";
      name = "pretty-ts-errors";
    }
    {
      publisher = "yzhang";
      name = "markdown-all-in-one";
    }
  ];

  marketplaceExtensions = map ({ publisher, name }: marketplaceExtension publisher name) [
    {
      publisher = "johnpapa";
      name = "vscode-cloak";
    }
    {
      publisher = "openai";
      name = "chatgpt";
    }
    {
      publisher = "parmesto";
      name = "islands-dark";
    }
    {
      publisher = "pmndrs";
      name = "pmndrs";
    }
    {
      publisher = "vitest";
      name = "explorer";
    }
  ];
in
{
  options.app.vscode.enable = lib.mkEnableOption "VS Code";

  config = lib.mkIf cfg.enable {
    programs.vscode = {
      enable = true;
      mutableExtensionsDir = false;
      package = pkgs.vscode;

      profiles.default = {
        extensions = packagedExtensions ++ marketplaceExtensions;

        userSettings = {
          "workbench.colorTheme" = "poimandres";
          "editor.fontFamily" = "Cascadia Code, Symbols Nerd Font, monospace";
          "workbench.iconTheme" = "material-icon-theme";
          "editor.rulers" = [
            80
            120
          ];
          "github.copilot.nextEditSuggestions.enabled" = true;
          "editor.minimap.enabled" = false;
          "[javascript]" = {
            "editor.defaultFormatter" = "esbenp.prettier-vscode";
          };
          "git.openRepositoryInParentFolders" = "never";
          "editor.formatOnSave" = true;
          "[typescript]" = {
            "editor.defaultFormatter" = "esbenp.prettier-vscode";
          };
          "[typescriptreact]" = {
            "editor.defaultFormatter" = "esbenp.prettier-vscode";
          };
          "[html]" = {
            "editor.defaultFormatter" = "esbenp.prettier-vscode";
          };
          "[json]" = {
            "editor.defaultFormatter" = "esbenp.prettier-vscode";
          };
          "[css]" = {
            "editor.defaultFormatter" = "esbenp.prettier-vscode";
          };
          "[scss]" = {
            "editor.defaultFormatter" = "esbenp.prettier-vscode";
          };
          "workbench.secondarySideBar.defaultVisibility" = "hidden";
          "editor.accessibilitySupport" = "on";
          "files.associations" = {
            "flake.lock" = "json";
            ".env*" = "dotenv";
          };
          "editor.tokenColorCustomizations" = {
            "[*Light*]" = {
              textMateRules = [
                {
                  scope = "ref.matchtext";
                  settings.foreground = "#000";
                }
              ];
            };
            "[*Dark*]" = {
              textMateRules = [
                {
                  scope = "ref.matchtext";
                  settings.foreground = "#fff";
                }
              ];
            };
            textMateRules = [
              {
                scope = "keyword.other.dotenv";
                settings.foreground = "#FF000000";
              }
            ];
          };
        };
      };
    };
  };
}
