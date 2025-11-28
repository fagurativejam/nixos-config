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
      # gaming
      steam
      discord

      # terminal
      wezterm
      
      # fonts
      pkgs.nerd-fonts.jetbrains-mono  
      pkgs.nerd-fonts.fira-code

      # Extra desktop tools
      copyq # clipboard manager
      grimblast # screenshot tool
      slurp # for region selection screenshots
      light # brightness control
      playerctl # commandline media controls
      mako # notification daemon
      hyprpaper # wallpaper daemon 
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
    xterm.enable = false;
    home-manager.enable = true;
  };
}
