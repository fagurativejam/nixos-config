{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.my.hyprland.enable {
    programs.hyprlock = {
      enable = true;
      settings = {
        general = { 
          disable_loading_bar = true;
          hide_cursor = true;
          no_fade_in = false;
          grace = 2;
        };
        background = [
          {
            monitor = "";
            path = "screenshot";
            blur_passes = 3;
            blur_size = 8;
            noise = 0.011;
            contrast = 0.8916;
            brightness = 0.5172;
          }
        ];
        input-field = [
          {
            monitor = "";
            size = "300, 50";
            outline_thickness = 4;
            dots_size = 0.2;
            dots_spacing = 0.15;
            dots_center = true;
            outer_color = "rgba(51, 204, 254, 0.93)";
            inner_color = "rgba(100, 100, 100, 0.39)";
            font_color = "rgba(255, 255, 255, 1)";
            fade_on_empty = false;
            placeholder_text = "<i>Enter Password</i>";
            position = "0, -120";
            halign = "center";
            valign = "center";
          }
        ];
        label = [
          {
            monitor = "";
            text = "$TIME";
            font_size = 82;
            color = "rgba(205, 214, 244, 1)";
            position = "0, 280";
            halign = "center";
            valign = "center";
            shadow_passes = 2;
          }
          {
            monitor = "";
            text = "cmd[update:1000] date +'%A, %B %d, %Y'";
            font_size = 22;
            color = "rgba(205, 214, 244, 1)";
            position = "0, 200";
            halign = "center";
            valign = "center";
          }
          {
            monitor = "";
            text = "'Sup $USER";
            font_size = 18;
            color = "rgba(205, 214, 244, 1)";
            position = "0, 150";
            halign = "center";
            valign = "center";
          }
        ];
      };
    };
    home.packages = with pkgs; [
      hyprpaper
    ];
  };
}
