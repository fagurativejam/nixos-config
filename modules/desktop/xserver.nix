{ config, pkgs, ... }:

{
  services.xserver = {
    enable = true;
    xkb.layout = "us";
  };

  services.displayManager.defaultSession = "hyprland";
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
}
