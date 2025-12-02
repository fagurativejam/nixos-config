{ lib, config, ... }:

{
  options.my.desktop.hyprland.execOnce = lib.mkOption {
    type = lib.types.listOf lib.types.str;
    default = [
      "waybar"
      "mako"
      "copyq"
      "hyprpaper"  # config file handled by wallpaper.nix
    ];
    description = "Programs to run once at Hyprland startup.";
  };

  config = {
    wayland.windowManager.hyprland.settings.exec-once =
      config.my.desktop.hyprland.execOnce;
  };
}
