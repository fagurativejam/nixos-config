{ config, lib, pkgs, ... }:
{
  options.my.desktop.wezterm.config = lib.mkOption {
    type = lib.types.path;
    description = "Path to wezterm.lua config.";
  };

  config = {
    programs.wezterm.enable = true;
    programs.wezterm.extraConfig = builtins.readFile config.my.desktop.wezterm.config;
  };
}