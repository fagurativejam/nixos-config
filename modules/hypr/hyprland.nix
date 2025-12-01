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
          "hyprpaper -c ~/.config/hypr/hyprpaper.conf"
        ];

        # Keybindings imported from ./keybindings.nix
        bind = config.my.desktop.hyprland.keybindings;

        # Window animations
        animations = {
          enabled = true;
          animation = [
            "windows,1,4,default"
            "fade,1,5,default"
            "workspaces,1,3,default"
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
      mako.enable = true;      # notifications
    };

    # ┌───────────────────────────────┐
    # │ 📦 Programs                   │
    # └───────────────────────────────┘
    programs = {
      wofi.enable = true;
    };

    # ┌───────────────────────────────┐
    # │ 📂 Files (symlinks)           │
    # └───────────────────────────────┘
    home.file.".config/hypr/hyprpaper.conf".source = ./hyprpaper.conf;
    home.file.".config/hypr/wallpapers".source = ./wallpapers;
  };
}
