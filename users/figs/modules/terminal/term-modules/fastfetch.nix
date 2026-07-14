{ pkgs, myTheme, ... }:

let
  colors = myTheme.colors;
  termColor = myTheme.toTermParam;
in
{
  # 1. Write the custom placeholder file.
  # Fastfetch interprets $1 through $7 as color tags, and $0 natively as the clear reset code.
  home.file.".config/fastfetch/custom_art.txt".text = ''
    $1__ $2 __
   $1/_/  $2\_\
    $1_\/$2\/_
 $6/\_\$7_\/_$3/_/\
 $6\/ /$5_$7/\$4_$3\ \/
   $5__/\$4/\__
   $5\_\  $4/_/
  '';

  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        source = "~/.config/fastfetch/custom_art.txt";
        type = "file";
        padding = {
          right = 1;
        };
        
        # 🎨 Clean, declarative color mapping using your centralized theme parameters
        color = {
          "1" = termColor colors.red1;       # Top-Left arm
          "2" = termColor colors.orange1;    # Top-Right arm
          "3" = termColor colors.yellow1;    # Mid-Right wing
          "4" = termColor colors.green1;     # Bottom-Right arm
          "5" = termColor colors.darkblue1;  # Bottom-Left arm
          "6" = termColor colors.purple1;    # Mid-Left wing
          "7" = termColor colors.fg0;        # Central Nucleus
        };
      };
      
      modules = [
        "title"
        "separator"
        "kernel"
        "os"
        "wm"
        "lm"
        "break"
        "cpu"
        "gpu"
        "memory"
        "disk"
        "swap"
        "break"
        "terminal"
        "shell"
      ];
    };
  };
}

