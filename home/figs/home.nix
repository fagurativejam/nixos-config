{ config, pkgs, ... }:

{
  imports = [
    ../../modules/hyprland-home.nix
    ../../modules/wezterm.nix
  ];

  my.desktop = {
    wezterm.config = ./wezterm.lua;
    hyprland.enable = true;
  };

  home = {
    username = "figs";
    homeDirectory = "/home/figs";
    stateVersion = "25.05";
    enableNixpkgsReleaseCheck = false;

    packages = with pkgs; [
      steam
      discord
      wezterm
      
      pkgs.nerd-fonts.jetbrains-mono  
      pkgs.nerd-fonts.fira-code
    ];
  };

  programs = {
    git = {
      enable = true;
      settings = {
        user.name = "fagurativejam";
        user.email = "fagurativejam@proton.me";
      };
    };

    home-manager.enable = true;
  };
}
