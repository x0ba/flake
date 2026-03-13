{ ... }:
{
  imports = [
    ../common/default.nix
    ../common/vscode.nix
  ];

  xdg.configFile."karabiner/karabiner.json".text = builtins.toJSON {
    profiles = [
      {
        complex_modifications.rules = [
          {
            description = "Custom Config";
            manipulators = [
              {
                from = {
                  key_code = "caps_lock";
                  modifiers.optional = [ "any" ];
                };
                parameters = {
                  basic.to_delayed_action_delay_milliseconds = 0;
                  basic.to_if_alone_timeout_milliseconds = 100;
                };
                to = [
                  {
                    key_code = "left_shift";
                    modifiers = [
                      "left_command"
                      "left_control"
                      "left_option"
                    ];
                  }
                ];
                to_if_alone = [ { key_code = "escape"; } ];
                type = "basic";
              }
              {
                from = {
                  key_code = "tab";
                  modifiers = {
                    mandatory = [
                      "left_shift"
                      "left_command"
                      "left_control"
                      "left_option"
                    ];
                    optional = [ "any" ];
                  };
                };
                to = [
                  {
                    key_code = "tab";
                    modifiers = [ "left_control" ];
                  }
                ];
                type = "basic";
              }
              {
                from = {
                  key_code = "k";
                  modifiers = {
                    mandatory = [
                      "left_shift"
                      "left_command"
                      "left_control"
                      "left_option"
                    ];
                    optional = [ "any" ];
                  };
                };
                to = [ { key_code = "up_arrow"; } ];
                type = "basic";
              }
              {
                from = {
                  key_code = "j";
                  modifiers = {
                    mandatory = [
                      "left_shift"
                      "left_command"
                      "left_control"
                      "left_option"
                    ];
                    optional = [ "any" ];
                  };
                };
                to = [ { key_code = "down_arrow"; } ];
                type = "basic";
              }
              {
                from = {
                  key_code = "u";
                  modifiers = {
                    mandatory = [
                      "left_shift"
                      "left_command"
                      "left_control"
                      "left_option"
                    ];
                    optional = [ "any" ];
                  };
                };
                to = [ { key_code = "page_up"; } ];
                type = "basic";
              }
              {
                from = {
                  key_code = "o";
                  modifiers = {
                    mandatory = [
                      "left_shift"
                      "left_command"
                      "left_control"
                      "left_option"
                    ];
                    optional = [ "any" ];
                  };
                };
                to = [ { key_code = "page_down"; } ];
                type = "basic";
              }
              {
                from = {
                  key_code = "h";
                  modifiers = {
                    mandatory = [
                      "left_shift"
                      "left_command"
                      "left_control"
                      "left_option"
                    ];
                    optional = [ "any" ];
                  };
                };
                to = [ { key_code = "left_arrow"; } ];
                type = "basic";
              }
              {
                from = {
                  key_code = "l";
                  modifiers = {
                    mandatory = [
                      "left_shift"
                      "left_command"
                      "left_control"
                      "left_option"
                    ];
                    optional = [ "any" ];
                  };
                };
                to = [ { key_code = "right_arrow"; } ];
                type = "basic";
              }
              {
                from = {
                  key_code = "a";
                  modifiers = {
                    mandatory = [
                      "left_shift"
                      "left_command"
                      "left_control"
                      "left_option"
                    ];
                    optional = [ "any" ];
                  };
                };
                to = [
                  {
                    key_code = "a";
                    modifiers = [ "left_command" ];
                  }
                ];
                type = "basic";
              }
              {
                from = {
                  key_code = "t";
                  modifiers = {
                    mandatory = [
                      "left_shift"
                      "left_command"
                      "left_control"
                      "left_option"
                    ];
                    optional = [ "any" ];
                  };
                };
                to = [
                  {
                    key_code = "t";
                    modifiers = [ "left_command" ];
                  }
                ];
                type = "basic";
              }
              {
                from = {
                  key_code = "c";
                  modifiers = {
                    mandatory = [
                      "left_shift"
                      "left_command"
                      "left_control"
                      "left_option"
                    ];
                    optional = [ "any" ];
                  };
                };
                to = [
                  {
                    key_code = "c";
                    modifiers = [ "left_command" ];
                  }
                ];
                type = "basic";
              }
              {
                from = {
                  key_code = "v";
                  modifiers = {
                    mandatory = [
                      "left_shift"
                      "left_command"
                      "left_control"
                      "left_option"
                    ];
                    optional = [ "any" ];
                  };
                };
                to = [
                  {
                    key_code = "v";
                    modifiers = [ "left_command" ];
                  }
                ];
                type = "basic";
              }
              {
                from = {
                  key_code = "w";
                  modifiers = {
                    mandatory = [
                      "left_shift"
                      "left_command"
                      "left_control"
                      "left_option"
                    ];
                    optional = [ "any" ];
                  };
                };
                to = [
                  {
                    key_code = "w";
                    modifiers = [ "left_command" ];
                  }
                ];
                type = "basic";
              }
            ];
          }
        ];
        name = "Default profile";
        selected = true;
        virtual_hid_keyboard.keyboard_type_v2 = "ansi";
      }
    ];
  };

  programs = {
    ghostty = {
      enable = true;
      package = null;
      settings = {
        font-family = "Cascadia Code";
        font-feature = "-liga";
        keybind = [
          "alt+left=esc:B"
          "alt+right=esc:F"
        ];
      };
    };

    zed-editor = {
      enable = true;
      package = null;
      mutableUserSettings = false;
      userSettings = {
        buffer_font_family = "Cascadia Code";
        vim_mode = true;
        icon_theme = {
          mode = "dark";
          light = "Zed (Default)";
          dark = "Zed (Default)";
        };
        ui_font_size = 16;
        buffer_font_size = 13.0;
        theme = {
          mode = "dark";
          light = "Ayu Light";
          dark = "Ayu Dark";
        };
      };
    };
  };
}
