{ pkgs, ... }:
{
  name = "Nordic";
  colors = {
    base  = "rgb(46,52,64)";    # #2e3440
    text  = "rgb(216,222,233)"; # #d8dee9
    blue  = "rgb(129,161,193)"; # #81a1c1
    peach = "rgb(235,203,139)"; # #ebcb8b
    mauve = "rgb(180,142,173)"; # #b48ead
    red   = "rgb(191,97,106)";  # #bf616a
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
