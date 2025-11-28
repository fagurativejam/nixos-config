{ config, pkgs, ... }:

{
  imports = [
    ../../modules/hyprland-home.nix
    ../../modules/wezterm.nix
  ];

  my.desktop.wezterm.config = ./wezterm.lua;
  my.desktop.hyprland.enable = true;

  home.username = "figs";
  home.homeDirectory = "/home/figs";
  home.stateVersion = "25.05";

  home.packages = with pkgs; [
    steam
    discord
    wezterm
    pkgs.nerd-fonts.jetbrains-mono  
    pkgs.nerd-fonts.fira-code
  ];

  programs.git = {
    enable = true;
    settings = {
      user.name = "fagurativejam";
      user.email = "fagurativejam@proton.me";
    };
  };

  programs.home-manager.enable = true;
}
