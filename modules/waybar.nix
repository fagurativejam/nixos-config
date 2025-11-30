{ config, pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    package = pkgs.waybar;

    # Waybar JSON-like config
    settings = {
      mainBar = {
        layer = "top";
        position = "bottom";
        mod = "dock";
        exclusive = true;
        passthrough = false;
        gtk-layer-shell = true;
        height = 0;

        "modules-left" = [
          "hyprland/workspaces"
        ];

        "modules-center" = [
          "tray"
        ];

        "modules-right" = [
          "custom/playerctl"
          "clock"
          "pulseaudio"
          "network"
          "cpu"
          "memory"
          "custom/exit"
        ];

        clock = {
          interval = 30;
          format = " %HH:%MM";
          on-click = "gsimplecal";
          tooltip = true;
          tooltip-format = "<big>{:%A, %d %B %Y}</big>\n<tt><small>{calendar}</small></tt>";
        };

        tray = {
          spacing = 5;
          show-passive-items = false;
        };

        network = {
          format-wifi = "{signalStrength}%  ";
          format-ethernet = "{ipaddr}";
          format-disconnected = "";
          on-click = "nm-connection-editor";
          on-click-right = "nmcli device wifi rescan";
          on-click-middle = "nmcli networking off && nmcli networking on";
        };

        pulseaudio = {
          format = "{volume}% {icon}";
          format-icons = ["" "" ""];
          on-click = "pavucontrol";
        };

        memory = {
          interval = 30;
          format = "{}% ";
          format-alt = "{used:0.1f}G ";
          max-length = 10;
        };

        cpu = {
          format = "{}% ";
          tooltip = false;
        };

        "custom/power" = {
          format = "⏻";
          tooltip = true;
          tooltip-format = "Power Menu";
          on-click = "~/.config/waybar/scripts/power-menu.sh";
        };

        "custom/exit" = {
          tooltip = false;
          format = "";
          on-click = "sleep 0.1 && wlogout";
        };

        "custom/notification" = {
          tooltip = false;
          format = "{} {icon}";
          format-icons = {
            notification = "<span foreground='red'><sup></sup></span>";
            none = "";
            dnd-notification = "<span foreground='red'><sup></sup></span>";
            dnd-none = "";
            inhibited-notification = "<span foreground='red'><sup></sup></span>";
            inhibited-none = "";
            dnd-inhibited-notification = "<span foreground='red'><sup></sup></span>";
            dnd-inhibited-none = "";
          };
          return-type = "json";
          exec-if = "which swaync-client";
          exec = "swaync-client -swb";
          on-click = "sleep 0.1 && swaync-client -t";
          escape = true;
        };

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
          sort-by-number = true;
          all-outputs = true;
          on-click = "activate";
          disable-scroll = false;
        };

        "hyprland/window" = {
          format = "{title}";
          icon = false;
          expand = true;
          max-length = 20;
          separate-outputs = true;
          rewrite = {
            "" = " 🙈 No Windows? ";
          };
        };

        "custom/playerctl" = {
          format = "{icon}  <span>{}</span>";
          return-type = "json";
          max-length = 333;
          exec = "playerctl -a metadata --format '{\"text\": \"{{artist}} ~ {{markup_escape(title)}}\", \"tooltip\": \"{{playerName}} : {{markup_escape(title)}}\", \"alt\": \"{{status}}\", \"class\": \"{{status}}\"}' -F";
          on-click-middle = "playerctl play-pause";
          on-click = "playerctl previous";
          on-click-right = "playerctl next";
          format-icons = {
            Playing = "<span foreground='#98BB6C'></span>";
            Paused = "<span foreground='#E46876'></span>";
          };
        };
      };
    };

    # CSS style inline
    style = ''
      * {
        font-family: "Ubuntu Mono Nerd Font", "JetBrainsMono Nerd Font", monospace;
        font-weight: 500;
        font-size: 14px;
        color: #eeeeee;
      }

      #waybar {
        background: rgba(0, 0, 0, 0);
        box-shadow: none;
        border: none;
        padding: 6px 12px;
      }

      #waybar * {
        background: transparent;
        border: none;
        box-shadow: none;
      }

      #waybar .module {
        padding: 0 10px;
        margin: 0 5px;
        border-radius: 6px;
        transition: background-color 0.3s ease;
      }

      #waybar .module:hover {
        background-color: rgba(255, 255, 255, 0.1);
      }

      #waybar .clock {
        font-weight: 600;
        font-size: 13px;
      }

      #waybar .battery,
      #waybar .cpu,
      #waybar .network {
        font-weight: 600;
      }

      #custom-notification {
        font-family: "JetBrainsMono Nerd Font";
      }

      .tooltip {
        background-color: rgba(0, 0, 0, 0.7);
        color: #eee;
        border-radius: 4px;
        padding: 3px 6px;
        font-size: 11px;
      }
    '';
  };

}
