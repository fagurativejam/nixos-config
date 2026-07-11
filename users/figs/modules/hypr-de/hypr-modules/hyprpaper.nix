{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.my.hyprland.enable {
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
    home.packages = with pkgs; [
      hyprpaper
    ];
  };
}

