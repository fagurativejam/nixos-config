{ config, lib, pkgs, myTheme, ... }:

let
  colors = myTheme.colors;
  hyprHex = myTheme.toHyprHex;
in
{
  options.my.hyprland = {
    enable = lib.mkEnableOption "Enable User Hyprland Config";
  };
  
  imports = [
    ./hypr-modules/gtk.nix
    ./hypr-modules/hypr-binds.nix
    ./hypr-modules/hypridle.nix
    ./hypr-modules/hyprlock.nix
    ./hypr-modules/hyprpaper.nix
    ./hypr-modules/hypr-scale.nix
    ./hypr-modules/hyprshot.nix
    ./hypr-modules/swaync.nix
    ./hypr-modules/waybar.nix
    ./hypr-modules/wlogout.nix
    ./hypr-modules/wofi.nix
  ];

  config = lib.mkIf config.my.hyprland.enable {

    wayland.windowManager.hyprland = {
      enable = true;
      configType = "hyprlang";
      settings = {
        monitor = [ "*,preferred,auto,auto" ];
        exec-once = [
          "waybar"
          "swaync"
          "systemctl --user start hyprpolkitagent"
        ];
        
        windowrule = [
          {
            name = "float-pavucontrol";
            match.class = "org.pulseaudio.pavucontrol";
            float = "on";
            size = "900 450";
            center = "on";
            opacity = "0.8 override 0.8 override 0.8 override";
          }
          {
            name = "float-nm-editor";
            match.class = "nm-connection-editor";
            float = "on";
            size = "700 450";
            center = "on";
            opacity = "0.8 override 0.8 override 0.8 override";
          }
          {
            name = "float-blueman";
            match.class = ".blueman-manager-wrapped";
            float = "on";
            size = "700 450";
            center = "on";
            opacity = "0.8 override 0.8 override 0.8 override";
          }
          {
            name = "thunar-styling";
            match.class = "thunar";
            opacity = "0.8 override 0.8 override 0.8 override";
          }
        ];
        input = {
          kb_layout = "us";
          numlock_by_default = true;
        };
        general = {
          gaps_in = 2.5;
          gaps_out = 7;
          border_size = 2;
          
          "col.active_border" = "${hyprHex colors.purple1 "ee"} ${hyprHex colors.cerulean "ee"} 45deg";
          "col.inactive_border" = "${hyprHex colors.surface2 "aa"}";
        };
        decoration = {
          rounding = 5;
          active_opacity = 0.95;
          inactive_opacity = 0.9;
          dim_inactive = true;
          dim_strength = 0.1;
          shadow = {
            enabled = true;
            range = 12;
            render_power = 3;
            color = "${hyprHex colors.crust "55"}";
          };
          blur = {
            enabled = true;
            size = 6;
            passes = 3;
            new_optimizations = true;
          };
        };
        animations = {
          enabled = true;
          bezier = [ "myBezier, 0.05, 0.9, 0.1, 1.05" ];
          animation = [
            "windows, 1, 5, myBezier"
            "windowsOut, 1, 5, default, popin 80%"
            "border, 1, 8, default"
            "fade, 1, 5, default"
            "workspaces, 1, 4, default, slide"
          ];
        };
        misc = {
          disable_hyprland_logo = true;
        };
      };
    };
    home.packages = with pkgs; [
      #connectivity
      networkmanagerapplet
      blueman
      hyprpolkitagent
      pavucontrol
      #media playback
      hyprshot
      drawing
      loupe
      clapper
    ];
  };
}
