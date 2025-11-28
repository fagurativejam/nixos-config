{ pkgs, ... }:
{
  name = "Nordic";
  colors = {
    base = "#2e3440";
    text = "#d8dee9";
    blue = "#81a1c1";
    peach = "#ebcb8b";
    mauve = "#b48ead";
    red = "#bf616a";
  };
  gtkTheme = {
    name = "Nordic";
    package = pkgs.nordic;
  };
  iconTheme = {
    name = "Papirus-Dark";
    package = pkgs.papirus-icon-theme;
  };
  cursorTheme = {
    name = "Bibata-Modern-Ice";
    package = pkgs.bibata-cursors;
  };
  font = "Fira Code";
}
