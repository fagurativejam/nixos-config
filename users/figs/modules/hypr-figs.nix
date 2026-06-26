# /users/figs/modules/hypr-figs.nix
{ config, lib, pkgs, ... }:

let
  # Bring down our unified central design tokens relative to this module
  palette = import ./palette.nix;
in
{
  options.my.hyprland = {
    enable = lib.mkEnableOption "Enable User Hyprland Config";
  };

  config = lib.mkIf config.my.hyprland.enable {

    wayland.windowManager.hyprland = {
      enable = true;
      configType = "hyprlang";

      settings = {
        monitor = [ "*,preferred,auto,auto" ];
        exec-once = [
          "waybar"
          "swaync"
          "nm-applet --no-indicator"
          "blueman-applet"
          "systemctl --user start hyprpolkitagent"
        ];
        
        windowrule = [
          {
            name = "float-pavucontrol";
            match.class = "org.pulseaudio.pavucontrol";
            float = "on";
            size = "900 450";
            center = "on";
          }
          {
            name = "float-nm-editor";
            match.class = "nm-connection-editor";
            float = "on";
            size = "700 450";
            center = "on";
          }
          {
            name = "float-blueman";
            match.class = ".blueman-manager-wrapped";
            float = "on";
            size = "700 450";
            center = "on";
          }
        ];

        input = {
          kb_layout = "us";
          numlock_by_default = true;
        };

        general = {
          gaps_in = 2.5;
          gaps_out = 7;
          border_size = 2;
          # Unified active border utilizing true Porsche Guards Red gradient tracking
          "col.active_border" = "${palette.hypr.guardsRed} ${palette.hypr.bgMain} 45deg";
          "col.inactive_border" = "rgba(${palette.overlay}aa)";
        };

        decoration = {
          rounding = 5;
          active_opacity = 0.95;
          inactive_opacity = 0.9;
          dim_inactive = true;
          dim_strength = 0.1;
          shadow = {
            enabled = true;
            range = 12;
            render_power = 3;
            color = "rgba(${palette.bgMain}55)";
          };
          blur = {
            enabled = true;
            size = 6;
            passes = 3;
            new_optimizations = true;
          };
        };

        animations = {
          enabled = true;
          bezier = [ "myBezier, 0.05, 0.9, 0.1, 1.05" ];
          animation = [
            "windows, 1, 5, myBezier"
            "windowsOut, 1, 5, default, popin 80%"
            "border, 1, 8, default"
            "fade, 1, 5, default"
            "workspaces, 1, 4, default, slide"
          ];
        };

        misc = {
          disable_hyprland_logo = true;
        };

        bind = [
          # Application Launchers
          "SUPER, D, exec, wofi --show drun" 
          "SUPER, RETURN, exec, wezterm" 
          "SUPER, E, exec, thunar"
          "SUPER, X, exec, wlogout -b 1"
          # General Keybindings
          "SUPER, Q, killactive"
          "SUPER, F, fullscreen"
          "SUPER, ESC, exit"
          "SUPER, SPACE, togglefloating"
          "SUPER, R, exec, hyprctl reload"
          # Playback
          "SUPER, F7, exec, playerctl play-pause"
          "SUPER, F8, exec, playerctl next"
          "SUPER, F6, exec, playerctl previous"
          "SUPER, F5, exec, playerctl stop"
          # Audio Controls
          "SUPER, F10, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
          "SUPER, F11, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
          "SUPER, F12, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
          # Workspace Switching
          "SUPER, 1, workspace, 1"
          "SUPER, 2, workspace, 2"
          "SUPER, 3, workspace, 3"
          "SUPER, 4, workspace, 4"
          "SUPER, 5, workspace, 5"
          "SUPER, 6, workspace, 6"
          "SUPER, 7, workspace, 7"
          "SUPER, 8, workspace, 8"
          "SUPER, 9, workspace, 9"
          "SUPER, 0, workspace, 10"
          # Move Active Window to Workspace
          "SUPER|SHIFT, 1, movetoworkspace, 1"
          "SUPER|SHIFT, 2, movetoworkspace, 2"
          "SUPER|SHIFT, 3, movetoworkspace, 3"
          "SUPER|SHIFT, 4, movetoworkspace, 4"
          "SUPER|SHIFT, 5, movetoworkspace, 5"
          "SUPER|SHIFT, 6, movetoworkspace, 6"
          "SUPER|SHIFT, 7, movetoworkspace, 7"
          "SUPER|SHIFT, 8, movetoworkspace, 8"
          "SUPER|SHIFT, 9, movetoworkspace, 9"
          "SUPER|SHIFT, 0, movetoworkspace, 10"
          # Cycle Workspaces
          "SUPER, TAB, workspace, +1"
          "SUPER|SHIFT, TAB, workspace, -1"
          # Move focus between windows
          "SUPER, H, movefocus, l   # focus left"
          "SUPER, L, movefocus, r   # focus right"
          "SUPER, K, movefocus, u   # focus up"
          "SUPER, J, movefocus, d   # focus down"
          # Move active window around
          "SUPER|SHIFT, H, movewindow, l"
          "SUPER|SHIFT, L, movewindow, r"
          "SUPER|SHIFT, K, movewindow, u"
          "SUPER|SHIFT, J, movewindow, d"
          # Swap active window with neighbor
          "SUPER|CTRL, H, swapwindow, l"
          "SUPER|CTRL, L, swapwindow, r"
          "SUPER|CTRL, K, swapwindow, u"
          "SUPER|CTRL, J, swapwindow, d"
          # Resize active window
          "SUPER|ALT, H, resizeactive, -50 0"
          "SUPER|ALT, L, resizeactive, 50 0"
          "SUPER|ALT, K, resizeactive, 0 -50"
          "SUPER|ALT, J, resizeactive, 0 50"
          # Minimize-like behavior
          "SUPER|SHIFT, M, movetoworkspace, special"
          "SUPER, M, togglespecialworkspace"
          # Session Management
          "SUPER|ALT, F1, exec, hyprlock"
          "SUPER|ALT, F4, exec, systemctl reboot"
          "SUPER|ALT, F5, exec, systemctl poweroff"
        ];
      };
    };

    programs.wofi = {
      enable = true;
      settings = {
        mode = "drun";
        prompt = "Search...";
        show-icons = true;
        lines = 10;
        width = 225;
      };
      style = ''
        * {
          font-family: "JetBrains Mono", monospace;
          font-size: 14px;
        }

        window {
          background-color: rgba(${palette.bgMain}, 0.95);
          border-radius: 12px;
          padding: 10px;
        }

        #input {
          margin: 8px;
          padding: 6px;
          border-radius: 8px;
          background-color: ${palette.css.surface};
          color: ${palette.css.textMain};
          min-width: 100%;
        }

        #entry {
          padding: 6px;
          border-radius: 6px;
          color: ${palette.css.textMain};
        }

        #entry:selected {
          background-color: ${palette.css.guardsRed};
          color: ${palette.css.bgCrust};
        }

        #text {
          margin-left: 6px;
          min-width: 100%;
          color: inherit;
        }

        list {
          background-color: ${palette.css.bgMain};
          padding: 6px;
        }

        list row {
          background-color: ${palette.css.surfaceMuted};
          color: ${palette.css.textMain};
          border-radius: 0;
          padding: 8px 10px;
          margin: 2px 0;
        }

        list row:hover {
          background-color: ${palette.css.overlay};
        }

        list row:selected {
          border: 2px solid ${palette.css.overlay};
          border-radius: 4px;
        }
      '';
    };

    programs.waybar = {
      enable = true;
      settings = {
        mainbar = {
          layer = "top";
          position = "bottom";
          modules-left = [ "hyprland/workspaces" ];
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
            format-disconnected = "󱛅";
            format-disabled = "󰯡";
            on-click = "nm-connection-editor";
          };
          "custom/notification" = { 
            tooltip = false;
            format = "{icon}";
            format-icons = {
              notification = "󰂚<span foreground='${palette.css.guardsRed}'><sup></sup></span>";
              none = "󰂚";
              dnd-notification = "󰂛<span foreground='${palette.css.guardsRed}'><sup></sup></span>";
              dnd-none = "󰂛";
              inhibited-notification = "󰂚<span foreground='${palette.css.guardsRed}'><sup></sup></span>";
              inhibited-none = "󰂚";
              dnd-inhibited-notification = "󰂛<span foreground='${palette.css.guardsRed}'><sup></sup></span>";
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

      style = ''
        window#waybar {
          background: transparent;
          border: none;
        }

        /* Structural Parent Containers using centralized tokens */
        #workspaces, .modules-right {
          background: rgba(${palette.css.nord1}, 0.8);
          border: 2px solid rgba(${palette.css.nord3}, 0.9);
          border-radius: 8px;
          margin: 2px 4px;
          padding: 2px 6px;
        }
        .modules-right { padding: 0; }

        /* Workspace Interaction Properties */
        #workspaces button {
          background: transparent;
          border: none;
          padding: 1px 4px;
          color: rgba(${palette.css.nord4}, 0.6);
          transition: all 0.2s ease-in-out;
        }
        #workspaces button:hover {
          color: ${palette.css.nord4};
          background: rgba(${palette.css.nord9}, 0.3);
          border-radius: 6px;
        }
        #workspaces button.active {
          background: rgba(${palette.css.nord9}, 0.8);
          color: ${palette.css.nord4};
          box-shadow: inset 0 -2px ${palette.css.nord9};
        }

        /* Combined Global Module Geometry Rules */
        #custom-power, #custom-notification, #cpu, #memory, #temperature, #pulseaudio, #bluetooth, #network, #clock, #mpris, #tray {
          padding: 2px 6px;
          margin: 2px 3px;
          border: 2px solid rgba(${palette.css.nord0}, 0.9);
          border-radius: 6px;
        }

        /* Standardized Heritage Palette Target Injection mapping */
        #custom-power { background: rgba(${palette.css.guardsRed}, 0.8); }
        #custom-notification, #tray { background: rgba(${palette.css.nord1}, 0.8); }
        #cpu { background: rgba(${palette.css.nord11}, 0.8); }
        #memory { background: rgba(${palette.css.nord12}, 0.8); }
        #temperature { background: rgba(${palette.css.nord13}, 0.8); }
        #pulseaudio, #mpris { background: rgba(${palette.css.nord14}, 0.8); }
        #bluetooth { background: rgba(${palette.css.nord7}, 0.8)}
        #network { background: rgba(${palette.css.nord9}, 0.8); }
        #clock { background: rgba(${palette.css.nord15}, 0.8); }
      '';
    };

    programs.hyprlock = {
      enable = true;
      settings = {
        general = { 
          disable_loading_bar = true;
          hide_cursor = true;
          no_fade_in = false;
          grace = 2;
        };
        background = [
          {
            monitor = "";
            path = "screenshot";
            blur_passes = 3;
            blur_size = 8;
            noise = 0.011;
            contrast = 0.8916;
            brightness = 0.5172;
          }
        ];
        input-field = [
          {
            monitor = "";
            size = "300, 50";
            outline_thickness = 4;
            dots_size = 0.2;
            dots_spacing = 0.15;
            dots_center = true;
            outer_color = "rgba(${palette.guardsRed}ee)";
            inner_color = "rgba(${palette.surface}64)";
            font_color = "rgba(${palette.textMain}ff)";
            fade_on_empty = false;
            placeholder_text = "<i>Enter Password</i>";
            position = "0, -120";
            halign = "center";
            valign = "center";
          }
        ];
        label = [
          {
            monitor = "";
            text = "$TIME";
            font_size = 82;
            color = "rgba(${palette.textMain}ff)";
            position = "0, 280";
            halign = "center";
            valign = "center";
            shadow_passes = 2;
          }
          {
            monitor = "";
            text = "cmd[update:1000] date +'%A, %B %d, %Y'";
            font_size = 22;
            color = "rgba(${palette.textMain}ff)";
            position = "0, 200";
            halign = "center";
            valign = "center";
          }
          {
            monitor = "";
            text = "'Sup $USER";
            font_size = 18;
            color = "rgba(${palette.guardsRed}ff)";
            position = "0, 150";
            halign = "center";
            valign = "center";
          }
        ];
      };
    };

    programs.wlogout = {
      enable = true;
      layout = [
        {
          label = "lock";
          action = "hyprlock";
          text = "󰌾 Lock: l";
          keybind = "l";
        }
        {
          label = "suspend";
          action = "systemctl suspend";
          text = "󰤄 Suspend: u";
          keybind = "u";
        }
        {
          label = "logout";
          action = "hyprctl dispatch exit 0";
          text = "󰍃 Logout: e";
          keybind = "e";
        }
        {
          label = "reboot";
          action = "systemctl reboot";
          text = "󰜉 Reboot: r";
          keybind = "r";
        }
        {
          label = "shutdown";
          action = "systemctl poweroff";
          text = "󰐥 Shutdown: s";
          keybind = "s";
        }
      ];
      style = ''
        window {
          background-color: rgba(${palette.css.nord0}, 0.85);
        }

        button {
          font-family: "JetBrains Mono Nerd Font", sans-serif;
          font-size: 20px;
          font-weight: bold;
          color: ${palette.css.nord4};
          background-color: rgba(${palette.css.bgMain}, 0.8);
          border: 2px solid rgba(${palette.css.nord1}, 0.5);
          border-radius: 12px;
          margin: 15px;
          transition: all 0.2s ease-in-out;
          background-repeat: no-repeat;
          background-position: center;
          background-image: none;
        }

        button:focus, button:hover {
          background-color: rgba(${palette.guardsRed}, 0.4); 
          border: 2px solid ${palette.css.nord8};
          color: ${palette.css.nord8};
        }

        #shutdown:focus, #shutdown:hover {
          background-color: rgba(${palette.guardsRed}, 0.2);
          border: 2px solid ${palette.css.guardsRed};
          color: ${palette.css.guardsRed};
        }
      '';
    };

    services.hypridle = {
      enable = true;
      settings = {
        general = {
          after_sleep_cmd = "hyprctl dispatch dpms on";
          before_sleep_cmd = "hyprlock";
          lock_cmd = "hyprlock";
        };
        listener = [  
          {
            timeout = 1800;
            on-timeout = "hyprlock";
          }
          {
            timeout = 2400;
            on-timeout = "hyprctl dispatch dpms off";
            on-resume = "hyprctl dispatch dpms on";
          }
          {
            timeout = 3000;
            on-timeout = "systemctl suspend";
          }
        ];
      };
    };

    services.hyprpaper = {
      enable = true;
      settings = {
        ipc = "on";
        splash = false;
        wallpaper = {
          monitor = "";
          path = "/home/figs/Bullshit/users/figs/wallpapers/wallpaper1.jpg";
        };
      };
    };

    services.swaync = {
      enable = true;
      settings = {
        positionX = "right";
        positionY = "bottom";
        layer = "top";
        control-center-margin-top = 0;
        control-center-margin-bottom = 10;
        control-center-margin-right = 10;
        control-center-margin-left = 0;
        text-icon = "";
      };
    };

    home.packages = with pkgs; [
      hyprpaper
      hyprlock
      hypridle
      swaynotificationcenter
      networkmanagerapplet
      blueman
      hyprpolkitagent
      pavucontrol
    ];
  };
}