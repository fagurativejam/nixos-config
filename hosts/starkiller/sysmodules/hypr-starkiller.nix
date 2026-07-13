{ config, lib, pkgs, ... }:

{
  options.my.hyprland = {
    enable = lib.mkEnableOption "Enable System Hyprland Config";
  };

  config = lib.mkIf config.my.hyprland.enable {

    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };

    #primary display manager: sddm
    services.displayManager = {
      enable = true;
      defaultSession = "hyprland"; 

      sddm = {
        enable = true;
        wayland.enable = true;
        package = pkgs.kdePackages.sddm; 
        theme = "catppuccin-mocha-mauve";
        autoNumlock = true; 
        
        extraPackages = with pkgs; [
          kdePackages.qtsvg
          qt6.qtwayland
          qt6.qtsvg
        ];
      };
    };

    #wayland portal
    xdg.portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
    };

    #allow hyprlock to lock screen
    security.pam.services.hyprlock = {};

    #sddm theming packages
    environment.systemPackages = with pkgs; [
      (catppuccin-sddm.override {
        flavor = "mocha";
        accent = "mauve";
        font = "JetBrains Mono";
        fontSize = "14";
        background = ../../../users/figs/wallpapers/wallpaper-nixos.jpg; 
        loginBackground = true;
      })

      catppuccin-cursors.mochaDark
      papirus-icon-theme
    ];
  };
}
