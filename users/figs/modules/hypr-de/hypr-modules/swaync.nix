{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.my.hyprland.enable {
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
	    swaynotificationcenter												
    ];
  };
}

