{ pkgs, ... }:
{
  name = "Catppuccin-Mocha";
  colors = {
    base = "#1e1e2e";
    text = "#cdd6f4";
    blue = "#89b4fa";
    peach = "#fab387";
    mauve = "#cba6f7";
    red = "#f38ba8";
  };
  gtkTheme = {
    name = "Catppuccin-Mocha-Standard-Blue-Dark";
    package = pkgs.catppuccin-gtk;
  };
  iconTheme = {
    name = "Papirus-Dark";
    package = pkgs.papirus-icon-theme;
  };
  cursorTheme = {
    name = "Bibata-Modern-Ice";
    package = pkgs.bibata-cursors;
  };
  font = "JetBrains Mono";
}
