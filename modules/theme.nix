{ config, pkgs, lib, ... }:

let
  # Pick your theme here (just change the string!)
  selectedTheme = "nordic";

  theme = import ./themes/${selectedTheme}.nix { inherit pkgs; };
in {
  # Install only the packages the theme defines
  home.packages =
    lib.optionals (theme ? gtkTheme) [ theme.gtkTheme.package ]
    ++ lib.optionals (theme ? iconTheme) [ theme.iconTheme.package ]
    ++ lib.optionals (theme ? cursorTheme) [ theme.cursorTheme.package ];

  # GTK theming
  gtk = lib.mkIf (theme ? gtkTheme) {
    enable = true;
    theme = theme.gtkTheme;
    iconTheme = theme.iconTheme;
    cursorTheme = theme.cursorTheme;
  };

  # Waybar styling
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

  # Hyprland borders
  wayland.windowManager.hyprland.settings.general = {
    border_size = 2;
    "col.active_border" =
      "${theme.colors.blue} ${theme.colors.peach} ${theme.colors.mauve} ${theme.colors.red}";
    "col.inactive_border" = "${theme.colors.base}";
  };
}

