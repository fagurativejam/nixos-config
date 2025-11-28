{ config, pkgs, lib, ... }:

let
  # Pick your theme here
  theme = import ../themes/nordic.nix { inherit pkgs; };
in {
  home.packages = [
    theme.gtkTheme.package
    theme.iconTheme.package
    theme.cursorTheme.package
  ];

  gtk = {
    enable = true;
    theme = theme.gtkTheme;
    iconTheme = theme.iconTheme;
    cursorTheme = theme.cursorTheme;
  };

  programs.waybar.style = ''
    * {
      font-family: "${theme.font}", monospace;
      background: ${theme.colors.base};
      color: ${theme.colors.text};
    }
    #workspaces button.active {
      background: ${theme.colors.mauve};
      color: ${theme.colors.blue};
    }
    #clock { color: ${theme.colors.peach}; }
  '';

  wayland.windowManager.hyprland.settings.general = {
    col.active_border =
      "${theme.colors.blue} ${theme.colors.peach} ${theme.colors.mauve} ${theme.colors.red}";
    col.inactive_border = theme.colors.base;
  };
}
