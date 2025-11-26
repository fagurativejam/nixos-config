{ config, pkgs, ... }:

{
  home.username = "figs";
  home.homeDirectory = "/home/figs";

  home.stateVersion = "25.05";

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    steam
    discord
    ghostty
    wezterm
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
