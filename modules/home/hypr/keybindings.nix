{ lib, ... }:

{
  options.my.desktop.hyprland = {
    # Application launchers
    launchBindings = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [
        "SUPER, D, exec, wofi --show drun"
        "SUPER, RETURN, exec, wezterm"
      ];
      description = "Keybindings for launching applications.";
    };

    # General window management
    generalBindings = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [
        "SUPER, Q, killactive"
        "SUPER, F, fullscreen"
        "SUPER, ESC, exit"
        "SUPER, SPACE, togglefloating"
        "SUPER, R, exec, hyprctl reload"
        "SUPER, F10, exec, pactl set-sink-mute @DEFAULT_SINK@ toggle"
        "SUPER, F11, exec, pactl set-sink-volume @DEFAULT_SINK@ -5%"
        "SUPER, F12, exec, pactl set-sink-volume @DEFAULT_SINK@ +5%"
      ];
      description = "General Hyprland keybindings.";
    };

    # Workspace switching
    workspaceBindings = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [
        "SUPER, 1, workspace, 1"
        "SUPER, 2, workspace, 2"
        "SUPER, 3, workspace, 3"
        "SUPER, 4, workspace, 4"
        "SUPER, 5, workspace, 5"
        "SUPER, 6, workspace, 6"
        "SUPER, 7, workspace, 7"
        "SUPER, 8, workspace, 8"
        "SUPER, 9, workspace, 9"
        "SUPER, 0, workspace, 10"
        "SUPER|SHIFT, 1, movetoworkspace, 1"
        "SUPER|SHIFT, 2, movetoworkspace, 2"
        "SUPER|SHIFT, 3, movetoworkspace, 3"
        "SUPER|SHIFT, 4, movetoworkspace, 4"
        "SUPER|SHIFT, 5, movetoworkspace, 5"
        "SUPER|SHIFT, 6, movetoworkspace, 6"
        "SUPER|SHIFT, 7, movetoworkspace, 7"
        "SUPER|SHIFT, 8, movetoworkspace, 8"
        "SUPER|SHIFT, 9, movetoworkspace, 9"
        "SUPER|SHIFT, 0, movetoworkspace, 10"
        "SUPER, TAB, workspace, +1"
        "SUPER|SHIFT, TAB, workspace, -1"
      ];
      description = "Workspace switching and moving bindings.";
    };

    # Window focus/movement
    movementBindings = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [
        "SUPER, H, movefocus, l"
        "SUPER, L, movefocus, r"
        "SUPER, K, movefocus, u"
        "SUPER, J, movefocus, d"
        "SUPER|SHIFT, H, movewindow, l"
        "SUPER|SHIFT, L, movewindow, r"
        "SUPER|SHIFT, K, movewindow, u"
        "SUPER|SHIFT, J, movewindow, d"
        "SUPER|CTRL, H, swapwindow, l"
        "SUPER|CTRL, L, swapwindow, r"
        "SUPER|CTRL, K, swapwindow, u"
        "SUPER|CTRL, J, swapwindow, d"
        "SUPER|ALT, H, resizeactive, -50 0"
        "SUPER|ALT, L, resizeactive, 50 0"
        "SUPER|ALT, K, resizeactive, 0 -50"
        "SUPER|ALT, J, resizeactive, 0 50"
        "SUPER, M, movetoworkspace, special"
        "SUPER, N, togglespecialworkspace"
      ];
      description = "Window focus, movement, swap, and resize bindings.";
    };

    # Combined list
    keybindings = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = lib.concatLists [
        config.my.desktop.hyprland.launchBindings
        config.my.desktop.hyprland.generalBindings
        config.my.desktop.hyprland.workspaceBindings
        config.my.desktop.hyprland.movementBindings
      ];
      description = "All Hyprland keybindings combined.";
    };
  };
}
