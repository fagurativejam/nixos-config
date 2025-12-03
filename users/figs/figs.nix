{ pkgs, ... }:

{
  home.username = "figs";
  home.homeDirectory = "/home/figs";

  programs.zsh.enable = true;
  programs.git.enable = true;
  programs.neovim.enable = true;

  home.stateVersion = "25.05"; # match your NixOS release
}
