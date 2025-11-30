{ config, pkgs, lib, ... }:

{
  imports = [ 
    ./keybindings.nix
  ];

  # ┌───────────────────────────────┐
  # │ ⚙️ Options                    │
  # └───────────────────────────────┘
  options.my.desktop.hyprland.enable =
    lib.mkEnableOption "Enable Hyprland for user";

  # ┌───────────────────────────────┐
  # │ 🖥️ Hyprland Configuration     │
  # └───────────────────────────────┘
  config = lib.mkIf config.my.desktop.hyprland.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      settings = {
        # Monitor setup
        monitor = [ ",preferred,auto,auto" ];

        # Programs to run once at startup
        exec-once = [ 
          "waybar"
          "mako"   # notifications
          "copyq"  # clipboard manager
        ];

        # Keybindings imported from ./keybindings.nix
        bind = config.my.desktop.hyprland.keybindings;

        # Window animations
        animations = {
          enabled = true;
          bezier = [ "myBezier,0.05,0.9,0.1,1.05" ];
          animation = [
            "windows,1,7,myBezier"
            "fade,1,10,default"
          ];
        };

        # Window rules (float specific apps)
        windowrule = [
          "float,class:^(pavucontrol)$"
          "float,class:^(blueman-manager)$"
        ];
      };
    };

    # ┌───────────────────────────────┐
    # │ 🎨 Extras (Services)          │
    # └───────────────────────────────┘
    services = {
      hyprpaper.enable = true; # wallpaper daemon
      mako.enable = true;      # notifications
    };

    # ┌───────────────────────────────┐
    # │ 📦 Programs                   │
    # └───────────────────────────────┘
    programs = {
      rofi.enable = true;

      waybar = {
        enable = true;
        settings = [
          {
            mainbar = {
              layer = "top";
              position = "bottom";
              height = 30;
              spacing = 10;
              modules-left   = [ "hyprland/workspaces" "hyprland/window" ];
              modules-center = [ "tray" ];
              modules-right  = [ "pulseaudio" "cpu" "memory" "clock" ];
            };
          }
        ];
        style = builtins.readFile ./themes/nord.css;
      };
    };
  };
}
