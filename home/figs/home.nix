{ config, pkgs, ... }:

{
  home.username = "figs";
  home.homeDirectory = "/home/figs";

  home.stateVersion = "25.05";

  home.packages = with pkgs; [
    htop
  ];

  #programs.zsh.enable = true;

#  programs.git = {
#    enable = true;
#    userName = "Fig Jam";
#    userEmail = "figs@example.com";
#  };

#  home.sessionVariables = {
#    EDITOR = "nvim";
#  };

  # Required for Home Manager
  programs.home-manager.enable = true;
}
