{ config, lib, pkgs, myTheme, ... }:

let
  colors = myTheme.colors;
  hex = myTheme.toHashHex;
  
  gtkCustomCss = ''
    @define-color window_bg_color ${hex colors.bg};
    @define-color window_fg_color ${hex colors.fg0};
    @define-color view_bg_color ${hex colors.crust};
    @define-color view_fg_color ${hex colors.fg0};
    @define-color headerbar_bg_color ${hex colors.mantle};
    @define-color headerbar_fg_color ${hex colors.fg0};
    @define-color accent_color ${hex colors.purple1};
    @define-color accent_bg_color ${hex colors.purple1};
    @define-color accent_fg_color ${hex colors.crust};
    @define-color popover_bg_color ${hex colors.mantle};
    @define-color card_bg_color ${hex colors.surface0};
  '';
in
{
  config = lib.mkIf config.my.hyprland.enable {
    
    dconf.settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
    };
    gtk = {
      enable = true;
      theme = {
        name = "adw-gtk3-dark";
        package = pkgs.adw-gtk3;
      };
      iconTheme = {
        name = "candy-icons";
        package = pkgs.candy-icons;
      };
      gtk4.theme = null;
      gtk4.extraConfig = {
        gtk-application-prefer-dark-theme = 1;
        gtk-theme-name = "adw-gtk3-dark";
      };
      font = {
        name = "JetBrains Mono";
        size = 10;
      };
    };
    xdg.configFile."gtk-3.0/gtk.css".text = gtkCustomCss;
    xdg.configFile."gtk-4.0/gtk.css".text = gtkCustomCss;
  };
}

