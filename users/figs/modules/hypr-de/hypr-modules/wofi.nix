{ config, lib, myTheme, ... }:

let
  colors = myTheme.colors;
  rgba = myTheme.toRGBACss;
in
{
  config = lib.mkIf config.my.hyprland.enable {
    programs.wofi = {
      enable = true;
      settings = {
        mode = "drun";
        prompt = "Search...";
        show-icons = true;
        lines = 10;
        width = 300;
      };
      style = /*lua*/''
        * {
          font-family: "JetBrains Mono", monospace;
          font-size: 14px;
        }
        window {
          background-color: ${rgba colors.bg "0.95"};
          border-radius: 12px;
          padding: 10px;
        }
        #input {
          margin: 8px;
          padding: 6px;
          border-radius: 8px;
          background-color: ${rgba colors.surface0 "1"};
          color: ${rgba colors.fg0 "1"};
          min-width: 100%;
        }
        #entry {
          padding: 6px;
          border-radius: 6px;
          color: ${rgba colors.fg0 "1"};
        }
        #entry:selected {
          background-color: ${rgba colors.blue1 "1"};
          color: ${rgba colors.bg "1"};
        }
        #text {
          margin-left: 6px;
          min-width: 100%;
          color: inherit;
        }
        list {
          background-color: ${rgba colors.blue1 "1"};
          padding: 6px;
        }
        list row {
          background-color: ${rgba colors.surface1 "1"};
          color: ${rgba colors.fg0 "1"};
          border-radius: 0;
          padding: 8px 10px;
          margin: 2px 0;
        }
        list row:hover {
          background-color: ${rgba colors.surface2 "1"};
        }
        list row:selected {
          border: 2px solid ${rgba colors.surface2 "1"};
          border-radius: 4px;
        }
      '';
    };
  };
}

