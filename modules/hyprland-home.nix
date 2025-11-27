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
		];

        bind = config.my.desktop.hyprland.keybindings;
      };
    };

    # Waybar
		programs.waybar = {
			enable = true;
			settings = [
				{
					layer = "top";
					position = "bottom";
					modules-left = [ "hyprland/workspaces" ];
					modules-center = [ "clock" ];
					modules-right = [ "pulseaudio" "network" ];
				}
			];
			style = ''
				* {
					font-family: "JetBrains Mono", monospace;
					font-size: 12px;
				}
				#clock { padding: 0 10px; }
			'';
		};


    # Rofi
    programs.rofi = {
      enable = true;
      theme = "gruvbox-dark";
    };
  };
}
