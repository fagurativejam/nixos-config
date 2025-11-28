{ config, pkgs, ... }:

{
  imports = [
    ../../modules/hyprland-home.nix
    ../../modules/wezterm.nix
    ../../modules/theme.nix
  ];

  my.desktop = {
    wezterm.config = ./wezterm.lua;
    hyprland.enable = true;
    catppuccin.enable = true;
  };

  home = {
    username = "figs";
    homeDirectory = "/home/figs";
    stateVersion = "25.05";
    enableNixpkgsReleaseCheck = false;

    packages = with pkgs; [
      # gaming
      steam
      discord

      # productivity
      wezterm
      libreoffice

      # fonts
      pkgs.nerd-fonts.jetbrains-mono  
      pkgs.nerd-fonts.fira-code

      # Extra desktop tools
      grimblast # screenshot tool
      slurp # for region selection screenshots
      light # brightness control
      playerctl # commandline media controls
      mako # notification daemon
      hyprpaper # wallpaper daemon 
      wl-clipboard # wayland clipboard utility
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
