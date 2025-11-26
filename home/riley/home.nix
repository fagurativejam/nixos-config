{ config, pkgs, ... }:

{
  # Identify the user
  home.username = "riley";
  home.homeDirectory = "/home/riley";

  home.stateVersion = "25.05";
  # Packages installed just for Riley
  home.packages = with pkgs; [
#    neovim
#    fastfetch
#    htop
#    firefox
  ];

  # Shell configuration
#  programs.zsh = {
#    enable = true;
#    ohMyZsh.enable = true;
#    ohMyZsh.theme = "robbyrussell";
#  };

  # Git setup
#  programs.git = {
#    enable = true;
#    userName = "Riley";
#    userEmail = "riley@example.com";
#  };

  # Environment variables
#  home.sessionVariables = {
#    EDITOR = "nvim";
#  };

  # Required for Home Manager itself
  programs.home-manager.enable = true;
}
