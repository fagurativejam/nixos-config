{ lib, config, pkgs, ... }:

{
  options.my.desktop.cava.enable =
    lib.mkEnableOption "Enable Cava audio visualizer with neon config";

  config = lib.mkIf config.my.desktop.cava.enable {
    home.packages = [ pkgs.cava ];

    # Drop in your custom config
    home.file.".config/cava/config".text = ''
      [general]
      framerate = 60
      bars = 64

      [input]
      method = pulse

      [output]
      method = ncurses
      channels = stereo

      [color]
      background = black
      foreground = cyan
      gradient = 1
      gradient_color_1 = magenta
      gradient_color_2 = blue
      gradient_color_3 = cyan
    '';
  };
}
