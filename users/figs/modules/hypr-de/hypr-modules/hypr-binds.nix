{ config, lib, ... }:

{
  config = lib.mkIf config.my.hyprland.enable {
    wayland.windowManager.hyprland.settings = {
      bind = [
        # Application Launchers
          "SUPER, D, exec, wofi --show drun" 
          "SUPER, RETURN, exec, wezterm" 
          "SUPER, E, exec, thunar"
          "SUPER, X, exec, wlogout -b 1"
          "SUPER, N, exec, swaync-client -t -sw"
        # Screenshotting
          "SUPER, S, exec, hyprshot -m region -o /home/figs/Pictures/Screenshots"
          "SUPER|SHIFT, S, exec, hyprshot -m window -o /home/figs/Pictures/Screenshots"
          "SUPER|CTRL, S, exec, hyprshot -m output -o /home/figs/Pictures/Screenshots"
        # General Keybindings
          "SUPER, Q, killactive"
          "SUPER, F, fullscreen"
          "SUPER, ESC, exit"
          "SUPER, SPACE, togglefloating"
          "SUPER, P, pin"
          "SUPER, R, exec, hyprctl reload"
        # Playback
          "SUPER, F7, exec, playerctl play-pause"
          "SUPER, F8, exec, playerctl next"
          "SUPER, F6, exec, playerctl previous"
          "SUPER, F5, exec, playerctl stop"
        # Workspace Switching
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
        # Move Active Window to Workspace
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
        # Cycle Workspaces
          "SUPER, TAB, workspace, +1"
          "SUPER|SHIFT, TAB, workspace, -1"
        # Move focus between windows
          "SUPER, H, movefocus, l   # focus left"
          "SUPER, L, movefocus, r   # focus right"
          "SUPER, K, movefocus, u   # focus up"
          "SUPER, J, movefocus, d   # focus down"
        # Move active window around
          "SUPER|SHIFT, H, movewindow, l"
          "SUPER|SHIFT, L, movewindow, r"
          "SUPER|SHIFT, K, movewindow, u"
          "SUPER|SHIFT, J, movewindow, d"
        # Swap active window with neighbor
          "SUPER|CTRL, H, swapwindow, l"
          "SUPER|CTRL, L, swapwindow, r"
          "SUPER|CTRL, K, swapwindow, u"
          "SUPER|CTRL, J, swapwindow, d"
        # Resize active window
          "SUPER|ALT, H, resizeactive, -50 0"
          "SUPER|ALT, L, resizeactive, 50 0"
          "SUPER|ALT, K, resizeactive, 0 -50"
          "SUPER|ALT, J, resizeactive, 0 50"
        # Minimize-like behavior
          "SUPER|SHIFT, M, movetoworkspace, special"
          "SUPER, M, togglespecialworkspace"
        # Session Management
          "SUPER|ALT, F1, exec, hyprlock"
          "SUPER|ALT, F4, exec, systemctl reboot"
          "SUPER|ALT, F5, exec, systemctl poweroff"
      ];
      binde = [
        # Audio Controls
          "SUPER, F10, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
          "SUPER, F11, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
          "SUPER, F12, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
      ];
      bindm = [
        "SUPER, mouse:272, movewindow"   # SUPER + Left Click drags windows
        "SUPER, mouse:273, resizewindow" # SUPER + Right Click resizes windows
      ];
    };
  };
}
