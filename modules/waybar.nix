{ config, pkgs, ... }:

{
  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        layer = "top";
        position = "bottom";
        height = 30;

        modules-left = [ "hyprland/workspaces" ];
        modules-center = [ "clock" "playerctl" ];
        modules-right = [ "cpu" "memory" "temperature" "pulseaudio" "network" "tray" ];

        "hyprland/workspaces" = {
          format = "{icon}";
          format-icons = {
            "1" = "1";
            "2" = "2";
            "3" = "3";
            "4" = "4";
            "5" = "5";
            "6" = "6";
            "7" = "7";
            "8" = "8";
            "9" = "9";
            "10" = "10";
          };
        };

        clock = {
          format = "{:%a %b %d %H:%M}";
          tooltip-format = "{:%Y-%m-%d}\n\n{calendar}";
          calendar = {
            exec = "cal --color=always";
            interval = 60;
          };
        };

        playerctl = {
          format = "{player_icon} {artist} - {title}";
          format-paused = " {player_icon} {artist} - {title}";
          format-stopped = "";
        };

        cpu = { format = " {usage}%"; };
        memory = { format = " {used:0.1f}G / {total:0.1f}G"; };
        temperature = { format = " {temperatureC}°C"; critical-threshold = 80; };

        pulseaudio = {
          format = "{volume}% ";
          format-muted = "";
          on-click = "pavucontrol";
        };

        network = {
          format-wifi = "{essid} ";
          format-ethernet = "{ifname} ";
          format-disconnected = "";
        };

        tray = { };
      };
    };

    style = ''
      /* Grounded box style for all modules */
      .modules-left > *,
      .modules-center > *,
      .modules-right > * {
        border-radius: 8px;                 /* rounded edges */
        padding: 4px 8px;                   /* spacing inside */
        margin: 2px 4px;                    /* spacing between boxes */
      }


      /* Highlight active workspace */
      #workspaces button.active {
        background: rgba(129, 161, 193, 0.6); /* lighter blue highlight */
        border: 2px solid #81a1c1;            /* outline box */
        border-radius: 8px;
      }

      /* Optional: lighter hues per module */
      #cpu { background: rgba(191, 97, 106, 0.3); }
      #memory { background: rgba(235, 203, 139, 0.3); }
      #temperature { background: rgba(208, 135, 112, 0.3); }
      #custom-gpu { background: rgba(136, 192, 208, 0.3); }
      #pulseaudio { background: rgba(180, 142, 173, 0.3); }
      #network { background: rgba(129, 161, 193, 0.3); }
      #clock { background: rgba(129, 161, 193, 0.3); }
      #playerctl { background: rgba(163, 190, 140, 0.3); }
      #tray { background: rgba(76, 86, 106, 0.3); }
    '';
  };
}
