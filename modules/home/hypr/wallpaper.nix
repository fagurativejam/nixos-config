{ lib, ... }:

{
  options.my.desktop.hyprland.wallpaper = lib.mkOption {
    type = lib.types.str;
    default = "~/.config/hypr/wallpapers/wallpaper1.jpg";
    description = "Default wallpaper path for Hyprpaper.";
  };

  options.my.desktop.hyprland.hyprpaperIpc = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable or disable Hyprpaper IPC.";
  };

  config = {
    home.file.".config/hypr/hyprpaper.conf".text = ''
      wallpaper = ,${config.my.desktop.hyprland.wallpaper}
      ipc = ${if config.my.desktop.hyprland.hyprpaperIpc then "on" else "off"}
    '';
  };
}
