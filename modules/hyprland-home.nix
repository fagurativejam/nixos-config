{ config, pkgs, lib, ... }:

{
  imports = [ 
    ./keybindings.nix
  ];
    
  options.my.desktop.hyprland.enable =
    lib.mkEnableOption "Enable Hyprland for user";

  config = lib.mkIf config.my.desktop.hyprland.enable {
    # Hyprland
    wayland.windowManager.hyprland = {
      enable = true;
      settings = {
        monitor = [ ",preferred,auto,auto" ];
        exec-once = [ 
          "waybar"
          "mako"          # notifications
          "copyq"         # clipboard manager
        ];

        bind = config.my.desktop.hyprland.keybindings;

        animations = {
          enabled = true;
          bezier = [ "myBezier,0.05,0.9,0.1,1.05" ];
          animation = [
            "windows,1,7,myBezier"
            "fade,1,10,default"
          ];
        };

        windowrule = [
					"float,class:^(pavucontrol)$"
					"float,class:^(blueman-manager)$"
        ];
      };
    };
    # Extras
    services = {
      hyprpaper.enable = true;   # wallpaper daemon
      mako.enable = true;        # notifications
    };

    programs = {
			rofi = {
      	enable = true;
    	};
			waybar = {
				enable = true;
				settings = [
					{
						layer = "top";
						position = "bottom";
						modules-left   = [ "hyprland/workspaces" "tray" ];
						modules-center = [ "clock" ];
						modules-right  = [ "pulseaudio" "network" "battery" "cpu" "memory" ];
					}
				];
			};
    };
  };
}