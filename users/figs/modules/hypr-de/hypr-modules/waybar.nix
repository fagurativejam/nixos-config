{ config, lib, myTheme,... }:

let
  colors = myTheme.colors;
  rgba = myTheme.toRGBACss;
  hex = myTheme.toHashHex;
in
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
            tooltip-format = "{essid} ({signalStrength}%)";
            on-click = "nm-connection-editor";
          };
          tray = {  };
          "custom/notification" = { 
            tooltip = false;
            format = "{icon}";
            format-icons = {
              notification = "󰂚<span foreground='${hex colors.porsche}'><sup></sup></span>";
              none = "󰂚";
              dnd-notification = "󰂛<span foreground='${hex colors.porsche}'><sup></sup></span>";
              dnd-none = "󰂛";
              inhibited-notification = "󰂚<span foreground='${hex colors.porsche}'><sup></sup></span>";
              inhibited-none = "󰂚";
              dnd-inhibited-notification = "󰂛<span foreground='${hex colors.porsche}'><sup></sup></span>";
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
      style =/*css*/ ''
        *{
          font-family: "Jetbrains Mono Nerd Font", "Symbols Nerd Font Mono";
          font-size: 13px;
        }
        window#waybar {
          background: transparent;
          border: none;
        }
        /* Structural Parent Containers using centralized tokens */
          #workspaces, .modules-center, .modules-right {
            background: ${rgba colors.surface0 "0.67"};
            border: 2px solid ${rgba colors.surface2 "0.9"};
            border-radius: 8px;
            color: ${rgba colors.fg0 "0.8"};
            margin: 2px 4px;
            padding: 2px 6px;
          }
          .modules-center, .modules-right { padding: 0; }
        /* Workspace Interaction Properties */
          #workspaces button {
            background: transparent;
            border: none;
            padding: 1px 4px;
            color: ${rgba colors.fg0 "0.6"};
            transition: all 0.2s ease-in-out;
          }
          #workspaces button:hover {
            color: ${rgba colors.white "1"};
            background: ${rgba colors.blue2 "0.3"};
            border-radius: 6px;
          }
          #workspaces button.active {
            background: ${rgba colors.blue2 "0.8"};
            color: ${rgba colors.white "1"};
            box-shadow: inset 0 -2px ${rgba colors.blue2 "1"};
          }
        /* Combined Global Module Geometry Rules */
          #custom-power, #custom-notification, #cpu, #memory, #temperature, #pulseaudio, #bluetooth, #network, #clock, #mpris, #tray {
            padding: 2px 6px;
            margin: 2px 3px;
            border: 2px solid ${rgba colors.surface2 "0.9"};
            border-radius: 6px;
          }
        /* Standardized Heritage Palette Target Injection mapping */
          #custom-power { background: ${rgba colors.porsche "1"}; color: ${hex colors.crust};}
          #custom-notification { background: ${rgba colors.fg0 "1"}; color: ${hex colors.crust};}
          #tray {background: ${rgba colors.surface1 "1"}; color: ${hex colors.white};}
          #cpu { background: ${rgba colors.red2 "1"}; color: ${hex colors.crust}; }
          #memory { background: ${rgba colors.orange2 "1"}; color: ${hex colors.crust};}
          #temperature { background: ${rgba colors.yellow2 "1"}; color: ${hex colors.crust};}
          #pulseaudio, #mpris { background: ${rgba colors.green2 "1"}; color: ${hex colors.crust};}
          #bluetooth { background: ${rgba colors.teal2 "1"}; color: ${hex colors.crust};}
          #network { background: ${rgba colors.blue2 "1"}; color: ${hex colors.crust};}
          #clock { background: ${rgba colors.purple2 "1"}; color: ${hex colors.crust};}
      '';
    };
  };
}
