{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.my.hyprland.enable {
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
    home.packages = with pkgs; [
      hypridle
    ];
  };
}

