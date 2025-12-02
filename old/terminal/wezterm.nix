{ pkgs, ... }:

{
  programs.wezterm = {
    enable = true;
    # Point directly to your wezterm.lua file
    extraConfig = builtins.readFile ../../home/figs/wezterm.lua;
  };
}
