{ config, lib, pkgs, ... }:

{
  options.my.desktop.hyprland.enable =
    lib.mkEnableOption "Enable Hyprland for user";

  imports = [
    ./keybindings.nix
    ./settings.nix
    ./startup.nix
    ./wallpaper.nix
  ];

  config = lib.mkIf config.my.desktop.hyprland.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      settings = {
        monitor     = [ ",preferred,auto,auto" ];
        bind        = config.my.desktop.hyprland.keybindings;
        animations  = config.my.desktop.hyprland.animations;
        decoration  = config.my.desktop.hyprland.decoration;
        windowrule  = config.my.desktop.hyprland.windowrules;
        exec-once   = config.my.desktop.hyprland.execOnce;
      };
    };

    # Supporting services/programs
    services.mako.enable = true;
    programs.wofi.enable = true;
  };
}
