{ config, lib, pkgs, ... }:

{
  options.my.hyprland = {
    enable = lib.mkEnableOption "Enable System Hyprland Config"
  };

  security.pam.services.hyprlock = {}; # Allow hyprlock to lock the screen on suspend

  programs.hyprland.enable = true

  services.greetd = {
    enable = true; # Enable greetd display manager
    settings = {

      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --asterisks --remember --cmd start-hyprland"; # Command to start Hyprland session with tuigreet
        user = "greeter"; # Use a dedicated greeter user for the login screen
      };

      tty_session = {
        command = "${pkgs.bash}/bin/bash"; # Command for a fallback TTY session (useful for troubleshooting
        user = "root"; # Run TTY session as root for full system access
      };
    };
  };

  environment.systemPackages = with pkgs; [
    tuigreet # Include tuigreet greeter for a customizable login screen
  ];
}
