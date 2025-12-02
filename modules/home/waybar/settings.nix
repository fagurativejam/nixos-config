{ lib, ... }:

{
  options.my.desktop.waybar.settings = lib.mkOption {
    type = lib.types.attrs;
    default = {
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
    description = "Waybar bar layout and module settings.";
  };
}
