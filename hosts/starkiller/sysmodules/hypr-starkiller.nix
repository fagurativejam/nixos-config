# /system/modules/hypr-starkiller.nix
{ inputs, config, lib, pkgs, ... }:

let
  # Import unified central design tokens relative to this system module
  palette = import ../../../users/figs/modules/palette.nix;
in
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

    programs.regreet = {
      enable = false;
      
      settings = {
        background = {
          # Update this to your preferred wallpaper asset path
          path = ../../../users/figs/wallpapers/wallpaper-nixos.jpg;
          fit = "Cover";
        };
        
        GTK = {
          application_prefer_dark_theme = true;
          theme_name = lib.mkForce "catppuccin-mocha-mauve-standard";
          icon_theme_name = lib.mkForce "Papirus-Dark";
          cursor_theme_name = lib.mkForce "catppuccin-mocha-mauve-cursors";
          font_name = lib.mkForce palette.font.gtkName;
        };
      };

      # Custom styling leveraging the unified design token pipeline
      extraCss = ''
        /* Force container elements into an absolute single-screen card flow */
        window {
          background-color: transparent;
        }

        /* Expands the child layer stack so fields display simultaneously */
        stack {
          background-color: transparent;
        }

        /* Blends out the multi-stage button wrapper completely */
        stack switcher, actionbar {
          display: none;
          opacity: 0;
        }

        /* The core authentication container card (Brightened Base Background) */
        #login-box {
          background-color: rgba(${palette.surface}, 0.92); 
          border: 2px solid ${palette.css.guardsRed};                 /* Porsche Guards Red accent framing */
          border-radius: 12px;
          padding: 40px;
          box-shadow: 0 12px 40px rgba(0, 0, 0, 0.65);
        }

        /* Dropdowns for Usernames and Sessions (Brightened text + border) */
        combobox, expression, arrow {
          background-color: ${palette.css.bgMain};
          color: ${palette.css.textMain};
          border: 1px solid ${palette.css.overlay};
          border-radius: 6px;
          padding: 8px;
        }

        /* Enhanced, high-contrast text fields */
        entry {
          background-color: ${palette.css.bgMain}; /* Deep contrasting dark crust input backgrounds */
          color: ${palette.css.textMain};            
          border: 1px solid ${palette.css.overlay}; /* Brighter surface border overlay */
          border-radius: 6px;
          padding: 10px;
        }

        entry:focus {
          border: 2px solid ${palette.css.guardsRed};
        }

        /* Action elements tracking the central design pipeline */
        button {
          background-color: ${palette.css.guardsRed};
          color: ${palette.css.bgCrust};
          font-weight: bold;
          border-radius: 6px;
          padding: 10px 20px;
        }

        button:hover {
          background-color: ${palette.css.surfaceMuted};
          color: ${palette.css.textMain};
        }

        label {
          color: ${palette.css.textMain};
          text-shadow: 0 1px 4px rgba(0, 0, 0, 0.8);
        }
      '';
    };

    services.displayManager = {
      enable = true;
      defaultSession = "hyprland"; 

      sddm = {
        enable = true;
        wayland.enable = true;
        package = pkgs.kdePackages.sddm; 
        theme = "catppuccin-mocha-mauve"; 
        
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