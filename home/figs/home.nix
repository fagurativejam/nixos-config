{ config, pkgs, ... }:

{
  imports = [
    ../../modules/hyprland-home.nix
    ../../modules/wezterm.nix
    ../../modules/ghostty.nix
  ];

  my.desktop.wezterm.config = ./wezterm.lua;

  my.desktop.hyprland.enable = true;

  home.username = "figs";
  home.homeDirectory = "/home/figs";
  home.stateVersion = "25.05";

  home.packages = with pkgs; [
    steam
    discord
    ghostty
    wezterm
  ];

  programs.git = {
    enable = true;
    userName = "fagurativejam";
    userEmail = "fagurativejam@proton.me";
  };

  programs.home-manager.enable = true;
}
