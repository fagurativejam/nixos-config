{ config, lib, ... }:

{
  config = lib.mkIf config.my.hyprland.enable {
    programs.waybar = {
      enable = true;
      settings = {
        mainbar = {
          layer = "top";
          position = "bottom";
          modules-left = [ "hyprland/workspaces" ];
          modules-center = [ "tray" "mpris" ];
          modules-right = [ "custom/power" "custom/notification" "cpu" "memory" "temperature" "pulseaudio" "bluetooth" "network" "clock" ];

          "hyprland/workspaces" = {
            format = "{icon}";
            format-icons = {
              "1" = "1"; "2" = "2"; "3" = "3"; "4" = "4"; "5" = "5";
              "6" = "6"; "7" = "7"; "8" = "8"; "9" = "9"; "10" = "10";
            };
          };
          clock = {
            format = "{:%a %b %d %I:%M %p}";
            tooltip-format = "{:%A, %B %d, %Y — %I:%M:%S %p}";
          };
          mpris = {
            format = "{player_icon} {artist} - {title}";
            format-paused = " {player_icon} {artist} - {title}";
            format-stopped = " Stopped";
          };
          cpu = { format = " {usage}%"; };
          memory = { format = " {used}G"; };
          temperature = {
            format = " {temperatureC}°C";
            critical-threshold = 80;
          };
          pulseaudio = {
            format = "{volume}%  ";
            format-muted = " Muted";
            on-click = "pavucontrol";
          };
          bluetooth = {
            format = " {status}";
            format-disabled = "󰂲";
            format-connected = "󰂯 {num_connections}";
            tooltip-format = "{device_alias}";
            tooltip-format-connected = " {device_enumerate}";
            tooltip-format-enumerate-connected = "{device_alias}";
            on-click = "blueman-manager";
          };
          network = {
            format-wifi = " ";
            format-ethernet = " ";
            format-disconnected = "󱛅 ";
            format-disabled = "󰯡 ";
            tooltip-format = "{essid}";
            on-click = "nm-connection-editor";
          };
          tray = {  };
          "custom/notification" = { 
            tooltip = false;
            format = "{icon}";
            format-icons = {
              notification = "󰂚<span foreground='#e60000'><sup></sup></span>";
              none = "󰂚";
              dnd-notification = "󰂛<span foreground='#e60000'><sup></sup></span>";
              dnd-none = "󰂛";
              inhibited-notification = "󰂚<span foreground='#e60000'><sup></sup></span>";
              inhibited-none = "󰂚";
              dnd-inhibited-notification = "󰂛<span foreground='#e60000'><sup></sup></span>";
              dnd-inhibited-none = "󰂛";
            };
            return-type = "json";
            exec-if = "which swaync-client";
            exec = "swaync-client -swb";
            on-click = "sleep 0.1 && swaync-client -t -sw";
            on-click-right = "sleep 0.1 && swaync-client -d -sw";
            escape = true;
          };
          "custom/power" = {
            format = "󰐥";
            tooltip = false;
            on-click = "wlogout -b 1";
          };
        };
      };
      style = /*lua*/ ''
        window#waybar {
          background: transparent;
          border: none;
        }
        /* Structural Parent Containers using centralized tokens */
          #workspaces, .modules-center, .modules-right {
            background: rgba(89, 89, 89, 0.67);
            border: 2px solid rgba(126, 135, 153, 0.9);
            border-radius: 8px;
            color: rgba(236, 239, 244, 0.8);
            margin: 2px 4px;
            padding: 2px 6px;
          }
          .modules-center, .modules-right { padding: 0; }
        /* Workspace Interaction Properties */
          #workspaces button {
            background: transparent;
            border: none;
            padding: 1px 4px;
            color: rgba(236, 239, 244, 0.6);
            transition: all 0.2s ease-in-out;
          }
          #workspaces button:hover {
            color: rgba(236, 239, 244, 1);
            background: rgba(129, 161, 193, 0.3);
            border-radius: 6px;
          }
          #workspaces button.active {
            background: rgba(129, 161, 193, 0.8);
            color: rgba(236, 239, 244, 1);
            box-shadow: inset 0 -2px rgba(129, 161, 193, 1);
          }
        /* Combined Global Module Geometry Rules */
          #custom-power, #custom-notification, #cpu, #memory, #temperature, #pulseaudio, #bluetooth, #network, #clock, #mpris, #tray {
            padding: 2px 6px;
            margin: 2px 3px;
            border: 2px solid rgba(46, 52, 64, 0.9);
            border-radius: 6px;
          }
        /* Standardized Heritage Palette Target Injection mapping */
          #custom-power { background: rgba(230, 0, 0, 1); }
          #custom-notification, #tray { background: rgba(76, 86, 106, 0.8); }
          #cpu { background: rgba(191, 97, 106, 0.8); }
          #memory { background: rgba(208, 135, 112, 0.8); }
          #temperature { background: rgba(235, 203, 139, 0.8); }
          #pulseaudio, #mpris { background: rgba(163, 190, 140, 0.8); }
          #bluetooth { background: rgba(143, 188, 187, 0.8); }
          #network { background: rgba(129, 161, 193, 0.8); }
          #clock { background: rgba(180, 142, 173, 0.8); }
      '';
    };
  };
}
