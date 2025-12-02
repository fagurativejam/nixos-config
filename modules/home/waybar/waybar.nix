{ config, lib, pkgs, ... }:

{
  options.my.desktop.waybar.enable =
    lib.mkEnableOption "Enable Waybar for user";

  imports = [
    ./settings.nix
  ];

  config = lib.mkIf config.my.desktop.waybar.enable {
    programs.waybar = {
      enable = true;
      settings = config.my.desktop.waybar.settings;

      # Load external CSS file
      style = builtins.readFile ./style.css;
    };
  };
}
