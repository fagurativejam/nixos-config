{ config, lib, ... }:

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
      style = /* lua */ ''
        * {
          font-family: "JetBrains Mono", monospace;
          font-size: 14px;
        }
        window {
          background-color: rgba(30, 30, 46, 0.95); /* base */
          border-radius: 12px;
          padding: 10px;
        }
        #input {
          margin: 8px;
          padding: 6px;
          border-radius: 8px;
          background-color: rgba(49, 50, 68, 1);
          color: rgba(205, 214, 244, 1);
          min-width: 100%;
        }
        #entry {
          padding: 6px;
          border-radius: 6px;
          color: rgba(205, 214, 244, 1);
        }
        #entry:selected {
          background-color: rgba(137, 180, 250, 1);
          color: rgba(30, 30, 46, 1);
        }
        #text {
          margin-left: 6px;
          min-width: 100%;
          color: inherit;
        }
        list {
          background-color: rgba(137, 180, 250, 1);
          padding: 6px;
        }
        list row {
          background-color: rgba(69, 71, 90, 1);
          color: rgba(205, 214, 244, 1);
          border-radius: 0;
          padding: 8px 10px;
          margin: 2px 0;
        }
        list row:hover {
          background-color: rgba(88, 91, 112, 1);
        }
        list row:selected {
          border: 2px solid  rgba(88, 91, 112, 1);
          border-radius: 4px;
        }
      '';
    };
  };
}
