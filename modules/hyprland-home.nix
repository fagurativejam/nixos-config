{ config, pkgs, lib, ... }:

{
  options.my.desktop.hyprland.enable =
    lib.mkEnableOption "Enable Hyprland for user";

  config = lib.mkIf config.my.desktop.hyprland.enable {
    home.packages = with pkgs; [
      hyprland
      waybar
      rofi-wayland
      kitty
    ];

    home.file.".config/hypr/hyprland.conf".text = ''
      monitor=,preferred,auto,auto
      exec-once = waybar
      exec-once = rofi -show drun
      exec-once = kitty
      bind = SUPER, RETURN, exec kitty
      bind = SUPER, D, exec rofi -show drun
    '';
  };
}
