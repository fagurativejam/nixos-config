{ config, pkgs, lib, ... }:

{
  options.my.desktop.catppuccin.enable =
    lib.mkEnableOption "Enable Catppuccin theme across Hyprland environment";

  config = lib.mkIf config.my.desktop.catppuccin.enable {
    # Install theme packages
    home.packages = with pkgs; [
      catppuccin-gtk
      papirus-icon-theme
      bibata-cursor-theme
      kvantum
    ];

    # GTK theming
    gtk = {
      enable = true;
      theme = {
        name = "Catppuccin-Mocha-Standard-Blue-Dark";
        package = pkgs.catppuccin-gtk;
      };
      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.papirus-icon-theme;
      };
      cursorTheme = {
        name = "Bibata-Modern-Ice";
        package = pkgs.bibata-cursor-theme;
      };
    };

    # Qt theming
    qt = {
      enable = true;
      style = {
        name = "kvantum";
        package = pkgs.kvantum;
      };
    };

    # Waybar styling
    programs.waybar.style = ''
      * {
        font-family: "JetBrains Mono", monospace;
        font-size: 12px;
        background: #1e1e2e; /* Catppuccin Mocha base */
        color: #cdd6f4;       /* text */
      }
      #workspaces button.active {
        background: #313244;
        color: #89b4fa;       /* blue accent */
      }
      #clock { padding: 0 10px; font-weight: bold; color: #fab387; }
    '';

    # Rofi theme
    programs.rofi = {
      enable = true;
      theme = "Catppuccin-Mocha";
    };

    # Hyprland borders
    wayland.windowManager.hyprland.settings.general = {
      col.active_border = "rgb(89b4fa) rgb(fab387) rgb(cba6f7) rgb(f38ba8)";
      col.inactive_border = "rgb(313244)";
    };
  };
}
