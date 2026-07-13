{ config, lib, pkgs, myTheme, ... }:

let
  colors = myTheme.colors;
  hex = myTheme.toHashHex;
in
{
  config = lib.mkIf config.my.hyprland.enable {
    services.swaync = {
      enable = true;
      
      settings = {
        positionX = "right";
        positionY = "top";
        layer = "top";
        cssPriority = "user";
        control-center-width = 380;
        control-center-height = 600;
        control-center-margin-top = 10;
        control-center-margin-bottom = 10;
        control-center-margin-right = 10;
        control-center-margin-left = 10;
        
        widgets = [
          "title"
          "dnd"
          "mpris"
          "volume"
          "notifications"
        ];
        
        widget-config = {
          title = {
            text = "Notifications";
            clear-button = true;
            button-text = "Clear All";
          };
          dnd = {
            text = "Silence";
          };
          mpris = {
            image-size = 96;
            image-radius = 8;
          };
          volume = {label = "  ";};
        };
      };

      style = /*css*/ ''
        /* Main Control Drawer Base */
        .control-center {
          background: ${hex colors.bg};
          border: 2px solid ${hex colors.surface2};
          border-radius: 12px;
          color: ${hex colors.fg0};
          padding: 12px;
        }

        /* Notification Banner Popups */
        .notification {
          background: ${hex colors.mantle};
          border: 2px solid ${hex colors.surface1};
          border-radius: 8px;
          color: ${hex colors.fg0};
          margin: 6px;
          padding: 10px;
        }

        /* Silence/DND Quick Toggle Switch Container */
        .widget-dnd {
          background: ${hex colors.crust};
          border-radius: 8px;
          padding: 8px;
          margin: 4px 0px;
        }
        .widget-dnd > switch {
          background: ${hex colors.surface1};
          border-radius: 12px;
        }
        .widget-dnd > switch:checked {
          background: ${hex colors.purple1};
        }

        /* Media Player & Sliders (Volume / Brightness) */
        .widget-mpris, .widget-volume {
          background: ${hex colors.mantle};
          border-radius: 8px;
          padding: 12px;
          margin: 6px 0px;
        }
        scale trough highlight {
          background: ${hex colors.purple1};
        }
        scale trough {
          background: ${hex colors.surface1};
          border-radius: 4px;
        }

        /* Clear All Action Typography */
        .widget-title button {
          background: ${hex colors.red1};
          color: ${hex colors.crust};
          border-radius: 6px;
          padding: 4px 10px;
        }
      '';
    };

    home.packages = with pkgs; [
      swaynotificationcenter                                                
    ];
  };
}
