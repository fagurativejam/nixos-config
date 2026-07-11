{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.my.hyprland.enable {
    gtk = {
      enable = true;
      gtk3.extraConfig = {
        gtk-application-prefer-dark-theme = 1;
      };
      gtk4.extraConfig = {
        gtk-application-prefer-dark-theme = 1;
      };
      # Hardcode solid Mocha colors into GTK3 apps (Alpha layer removed)
      gtk3.extraCss = /*css*/ ''
        @define-color window_bg_color #1e1e2e;
        @define-color window_fg_color #cdd6f4;
        @define-color view_bg_color #11111b;
        @define-color view_fg_color #cdd6f4;
        @define-color headerbar_bg_color #181825;
        @define-color headerbar_fg_color #cdd6f4;
        @define-color accent_color #cba6f7;
        @define-color accent_bg_color #cba6f7;
        @define-color accent_fg_color #11111b;
      '';
      # Hardcode solid Mocha colors into GTK4/Libadwaita apps (Alpha layer removed)
      gtk4.extraCss = /*css*/ ''
        @define-color window_bg_color #1e1e2e;
        @define-color window_fg_color #cdd6f4;
        @define-color view_bg_color #11111b;
        @define-color view_fg_color #cdd6f4;
        @define-color headerbar_bg_color #181825;
        @define-color headerbar_fg_color #cdd6f4;
        @define-color accent_color #cba6f7;
        @define-color accent_bg_color #cba6f7;
        @define-color accent_fg_color #11111b;
      '';
      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.papirus-icon-theme;
      };
      cursorTheme = {
        name = "catppuccin-mocha-dark-cursors";
        package = pkgs.catppuccin-cursors.mochaDark;
        size = 24;
      };
      font = {
        name = "JetBrains Mono";
        size = 10;
      };
    };
  };
}

