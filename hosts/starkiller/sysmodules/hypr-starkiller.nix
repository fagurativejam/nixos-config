{ inputs, config, lib, pkgs, ... }:

{
  options.my.hyprland = {
    enable = lib.mkEnableOption "Enable System Hyprland Config";
  };

  config = lib.mkIf config.my.hyprland.enable {

    security.pam.services.hyprlock = {}; # Allow hyprlock to lock the screen on suspend

    programs.hyprland.enable = true;

    services.greetd = {
      enable = false; # Enable greetd display manager
      settings = {

        default_session = {
          command = let
            gstPlugins = with pkgs.gst_all_1; [
              gstreamer
              gst-plugins-base
              gst-plugins-good
            ];
            pluginPath = pkgs.lib.makeSearchPathOutput "lib" "lib/gstreamer-1.0" gstPlugins;
          in "env GST_PLUGIN_SYSTEM_PATH_1_0=${pluginPath} ${pkgs.cage}/bin/cage -d -s -m last -- ${pkgs.regreet}/bin/regreet";
          user = "greeter"; # Use a dedicated greeter user for the login screen
        };

        tty_session = {
          command = "${pkgs.bash}/bin/bash"; # Command for a fallback TTY session (useful for troubleshooting)
          user = "root"; # Run TTY session as root for full system access
        };
      };
    };

    services.displayManager = {
      enable = true;
      defaultSession = "hyprland"; 

      sddm = {
        enable = true;
        wayland.enable = true;
        package = pkgs.kdePackages.sddm; 
        theme = "catppuccin-mocha"; 
        
        # Force SDDM to run its own graphical display wrapper inside a clean PAM session seat
        settings = {
          Autologin = {
            Session = "hyprland.desktop";
          };
        };

        extraPackages = with pkgs; [
          kdePackages.qtsvg
          kdePackages.qtmultimedia
          qt6.qt5compat
        ];
      };
    };

    # Critical session architecture for standalone Hyprland setups
    services.dbus.enable = true;
    xdg.portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
    };

    environment.systemPackages = with pkgs; [
      (catppuccin-sddm.override {
        flavor = "mocha";
        accent = "mauve";
        font = palette.font.family; # Dynamic font family token
        fontSize = palette.font.size; # Dynamic font size token
        background = ../../../users/figs/wallpapers/wallpaper-nixos.jpg; 
        loginBackground = true;
      })

      (catppuccin-gtk.override { accents = [ "mauve" ]; size = "standard"; variant = "mocha"; })
      catppuccin-cursors.mochaMauve
      papirus-icon-theme
    ];
  };
}