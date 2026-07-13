{ pkgs, myTheme, ... }:

let
  inherit (myTheme) colors sub hexToDec;

  # Helper function to turn a hex string ("f38ba8") into a Fastfetch-compatible "38;2;R;G;B" parameter
  toFastfetchTruecolor = hex:
    let
      r = toString (hexToDec (sub 0 2 hex));
      g = toString (hexToDec (sub 2 2 hex));
      b = toString (hexToDec (sub 4 2 hex));
    in "38;2;${r};${g};${b}";
in
{
  # 1. Write the custom placeholder file.
  # Fastfetch interprets $1 through $7 as color tags, and $0 natively as the clear reset code.
  home.file.".config/fastfetch/custom_art.txt".text = ''
    $1__ $2 __
   $1/_/  $2\_\
    $1_\/$2\/$3_
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
          right = 4;
        };
        
        # 🎨 FIXED: Wrapped every hex value into Fastfetch's required "38;2;R;G;B" format specification
        color = {
          "1" = toFastfetchTruecolor colors.red1;       # Top-Left arm
          "2" = toFastfetchTruecolor colors.orange1;    # Top-Right arm
          "3" = toFastfetchTruecolor colors.yellow1;    # Mid-Right wing
          "4" = toFastfetchTruecolor colors.green1;     # Bottom-Right arm
          "5" = toFastfetchTruecolor colors.darkblue1;  # Bottom-Left arm
          "6" = toFastfetchTruecolor colors.purple1;    # Mid-Left wing
          "7" = toFastfetchTruecolor colors.fg0;        # Central Nucleus
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

