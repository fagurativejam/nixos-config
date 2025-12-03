{ pkgs, ... }:

{
  home.username = "figs";
  home.homeDirectory = "/home/figs";

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      monitor = [ "*,preferred,auto,auto" ];
      exec-once = [
        "wofi --show drun"
        "waybar"
        "hyprpaper"
      ];
      
      input = {
        kb_layout ="us";
        kb_options = "caps:escape";
      };

      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        "col.active_border" = "rgba(33ccffee)";
        "col.inactive_border" = "rgba(595959aa)";
      };

      decoration = {
        rounding = 5;
        active_opacity = 0.95;
        inactive_opacity = 0.9;
        dim_inactive = true;
        dim_strength = 0.1;
      };

      animations = {
        enabled = true;
      };

      bind = [
        # --- Application Launchers ---
        "SUPER, D, exec, wofi --show drun" 
        "SUPER, RETURN, exec, wezterm" 
        # --- General Keybindings ---
        "SUPER, Q, killactive"
        "SUPER, F, fullscreen"
        "SUPER, ESC, exit"
        "SUPER, SPACE, togglefloating"
        "SUPER, R, exec, hyprctl reload"
        "SUPER, F10, exec, pactl set-sink-mute @DEFAULT_SINK@ toggle"	
        "SUPER, F11, exec, pactl set-sink-volume @DEFAULT_SINK@ -5%"
        "SUPER, F12, exec, pactl set-sink-volume @DEFAULT_SINK@ +5%"
        # --- Workspace Switching ---
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
        # --- Move Active Window to Workspace ---
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
        # --- Cycle Workspaces ---
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
        "SUPER|SHIFT, M, movetoworkspace, special"   # send to scratchpad
        "SUPER, M, togglespecialworkspace"     # toggle scratchpad
      ];
    };
  };

  programs = {
    vscode.enable = true;
    hyfetch.enable = true;
  };

  programs.wezterm = {
    enable = true;
    extraConfig = ''
      local wezterm = require 'wezterm'

      wezterm.on("update-right-status", function(window, pane)
        local date = wezterm.strftime("%Y-%m-%d %H:%M")
        window:set_right_status(date)
      end)

      wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
        local title = tab.active_pane.title
        if tab.is_active then
          return {
            {Background={Color="#1e1e2e"}},
            {Foreground={Color="#cdd6f4"}},
            {Text=" " .. title .. " "},
          }
        end
        return title
      end)

      return {
        font = wezterm.font_with_fallback {
          "JetBrains Mono Nerd Font",
          "Fira Code",
        },
        font_size = 12.0,
        color_scheme = "Catppuccin Mocha", -- or "Dracula" , "Catppuccin Mocha" , "Tokyo Night"
        window_background_opacity = 0.85,
        window_padding = { left = 8, right = 8, top = 8, bottom = 8 },
        enable_tab_bar = true,
        hide_tab_bar_if_only_one_tab = false,
        inactive_pane_hsb = { saturation = 0.9, brightness = 0.8 },
        use_fancy_tab_bar = false,
        window_decorations = "NONE",
        scrollback_lines = 10000,

        keys = {
          -- Split horizontally
          {key="|", mods="CTRL|SHIFT", action=wezterm.action.SplitHorizontal{domain="CurrentPaneDomain"}},
          -- Split vertically
          {key="l", mods="CTRL|SHIFT", action=wezterm.action.SplitVertical{domain="CurrentPaneDomain"}},
          -- New tab
          {key="t", mods="CTRL|SHIFT", action=wezterm.action.SpawnTab "CurrentPaneDomain"},
          -- Switch tabs
          {key="Tab", mods="CTRL", action=wezterm.action.ActivateTabRelative(1)},
          {key="Tab", mods="CTRL|SHIFT", action=wezterm.action.ActivateTabRelative(-1)},
          {key="w", mods="CTRL|ALT", action=wezterm.action.CloseCurrentPane{confirm=true}},
        },
        -- Multiplexer persistence
        unix_domains = {
          { name = "mydomain" },
        },
        default_gui_startup_args = { "connect", "local" },
      }
    '';
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
        background-color: rgba(30, 30, 46, 0.95); /* base */
        border-radius: 12px;
        padding: 10px;
      }

      #input {
        margin: 8px;
        padding: 6px;
        border-radius: 8px;
        background-color: rgba(49, 50, 68, 1.0); /* surface0 */
        color: rgba(205, 214, 244, 1.0);         /* text */
        min-width: 100%;
      }

      #entry {
        padding: 6px;
        border-radius: 6px;
        color: rgba(205, 214, 244, 1.0);
      }

      #entry:selected {
        background-color: rgba(137, 180, 250, 1.0); /* blue accent */
        color: rgba(30, 30, 46, 1.0);
      }

      #text {
        margin-left: 6px;
        min-width: 100%;
        color: inherit;
      }

      list {
        background-color: rgba(137, 180, 250, 1.0); /* base */
        padding: 6px;
      }

      list row {
        background-color: rgba(69, 71, 90, 1.0);  /* surface1 */
        color: rgba(205, 214, 244, 1.0);
        border-radius: 0;                          /* remove rounding to avoid corners */
        padding: 8px 10px;
        margin: 2px 0;
      }

      list row:hover {
        background-color: rgba(88, 91, 112, 1.0); /* surface2 */
      }

      list row:selected {
        border: 2px solid  rgba(88, 91, 112, 1.0);
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

    style = "
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
        padding: 0;
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
    ";
  };

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;
    shellAliases = {
      hmrbld  = "nix run .#home-manager -- switch --flake .#figs";
      hm      = "nix run .#home-manager --";
      rebuild = "sudo nixos-rebuild switch --flake .#starkiller";
      update  = "nix flake update";
      garbage = "sudo nix-collect-garbage -d";
    };
    oh-my-zsh = {
      enable = true;
      theme = "angoster" ;
      plugins = [ "git" ];
      initExtra= "";
    };
  };

  programs.bash = {
    enable = true;
    shellAliases = {
      hm = "nix run .#home-manager --";
      hmrbld = "nix run .#home-manager -- switch --flake .#figs";
      rebuild = "sudo nixos-rebuild switch --flake .#starkiller";
      update = "nix flake update";
    };
  };

  programs.git = {
    enable = true;
    settings = {
      user.name = "fagurativejam";
      user.email = "fagurativejam@proton.me";
    };
  };

  home.packages = with pkgs; [
    cowsay
    fortune
    htop
    nnn
    fzf
    discord
    steam
    spotify
    libreoffice
    cava
    firefox
    hyprpaper
  ];

  xdg.configFile."hypr/hyprpaper.conf".text = ''
    preload = ./wallpapers/wallpaper1.jpg
    wallpaper = *,./wallpapers/wallpaper1.jpg
  '';

  home.stateVersion = "25.05"; # match your NixOS release
}
