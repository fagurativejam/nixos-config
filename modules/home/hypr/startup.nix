{ lib, ... }:

{
  options.my.desktop.hyprland.execOnce = lib.mkOption {
    type = lib.types.listOf lib.types.str;
    default = [
      "waybar"
      "mako"
      "copyq"
      "hyprpaper -c ~/.config/hypr/hyprpaper.conf"
    ];
  };
}
