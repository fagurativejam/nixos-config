{pkgs, ...}:
{
  imports = [
    ./term-modules/bash.nix
    ./term-modules/fastfetch.nix
    ./term-modules/nixvim/nixvim.nix
    ./term-modules/wezterm.nix
    ./term-modules/zsh.nix
  ];
  programs = {
    hyfetch.enable=true;
  };
  home.packages = with pkgs; [
    #terminal utils
      cowsay
      fortune
      bottom
      lf
      cava
      sl
      pipes
  ];
}
