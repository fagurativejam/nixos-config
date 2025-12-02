{ config, pkgs, ... }:

{
  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        layer = "top";
        position = "bottom";
        height = 28;

        modules-left = [ "hyprland/workspaces" ];
        modules-center = [ "tray" "mpris" ];
        modules-right = [ "cpu" "memory" "temperature" "pulseaudio" "network" "clock" ];

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
          format-disconnected = " No Player";
        };

        cpu = { format = " {usage}%"; };
        memory = { format = " {used}G / {total}G"; };
        temperature = {
          format = " {temperatureC}°C";
          critical-threshold = 80;
        };

        pulseaudio = {
          format = "{volume}% ";
          format-muted = " Muted";
          on-click = "pavucontrol";
        };

        network = {
          format-wifi = "{essid} ";
          format-ethernet = "{ifname} ";
          format-disconnected = " Disconnected";
        };

        tray = { };
      };
    };

    style = ''
      window#waybar {
        background: transparent;
        border: none;
      }

      .module {
        border-radius: 8px;
        padding: 1px 4px;
        margin: 1px 3px;
        min-width: 16px;
        min-height: 16px;
      }

      /* Left group (workspaces) */
      #workspaces {
        background: rgba(76, 86, 106, 0.8);
        border: 2px solid #81a1c1;
        border-radius: 8px;
        margin: 2px 4px;
        padding: 2px 6px;
      }

      #workspaces button {
        background: transparent;
        border: none;
        padding: 1px 4px;
        color: rgba(236, 239, 244, 0.6);
        transition: color 0.2s ease-in-out,
                    background 0.2s ease-in-out;
      }

      #workspaces button:hover {
        color: rgba(236, 239, 244, 1.0);
        background: rgba(129, 161, 193, 0.3);
        border-radius: 6px;
      }

      #workspaces button.active {
        background: rgba(129, 161, 193, 0.8);
        color: rgba(236, 239, 244, 1.0);
        box-shadow: inset 0 -2px #81a1c1;
      }

      /* Center group */
      .modules-center {
        background: rgba(76, 86, 106, 0.8);
        border: 2px solid #81a1c1;
        border-radius: 8px;
        margin: 2px 4px;
        padding: 0; /* keep tray icons safe */
      }

      /* Right group */
      .modules-right {
        background: rgba(76, 86, 106, 0.8);
        border: 2px solid #81a1c1;
        border-radius: 8px;
        margin: 2px 4px;
        padding: 0;
      }

      /* Individual module accent colors */
      #cpu { background: rgba(191, 97, 106, 0.8); padding: 2px 6px; }
      #memory { background: rgba(208, 135, 112, 0.8); padding: 2px 6px; }
      #temperature { background: rgba(235, 203, 139, 0.8); padding: 2px 6px; }
      #pulseaudio { background: rgba(163, 190, 140, 0.8); padding: 2px 6px; }
      #network { background: rgba(129, 161, 193, 0.8); padding: 2px 6px; }
      #clock { background: rgba(180, 142, 173, 0.8); padding: 2px 6px; }
      #mpris { background: rgba(163, 190, 140, 0.8); padding: 2px 6px; }
      #tray { background: rgba(76, 86, 106, 0.8); padding: 2px 6px; }
    '';
  };
}
