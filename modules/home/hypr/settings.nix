{ lib, ... }:

{
  options.my.desktop.hyprland = {
    animations = lib.mkOption {
      type = lib.types.attrs;
      default = {
        enabled = true;
        animation = [
          "windows,1,4,default"
          "fade,1,5,default"
          "workspaces,1,3,default"
        ];
      };
      description = "Hyprland animation settings.";
    };

    decoration = lib.mkOption {
      type = lib.types.attrs;
      default = {
        active_opacity = 0.95;
        inactive_opacity = 0.9;
        dim_inactive = true;
        dim_strength = 0.1;
      };
      description = "Hyprland window decoration settings.";
    };

    windowrules = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [
        "float,class:^(pavucontrol)$"
        "float,class:^(blueman-manager)$"
        "opacity 0.5,class:^(wofi)$"
      ];
      description = "Window rules for Hyprland (float, opacity, etc.).";
    };
  };
}
