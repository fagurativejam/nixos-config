{lib, ...}:
{
  options.my.desktop.hyprland.keybindings = lib.mkOption {
    type = lib.types.listOf lib.types.str;
    default = [
 			# --- Application Launchers ---
			"SUPER, D, exec, rofi -show drun" 
			"SUPER, RETURN, exec, wezterm" 
			# --- General Keybindings ---
			"SUPER, Q, killactive"
			"SUPER, F, fullscreen"
			"SUPER, ESC, exit"
			"SUPER, SPACE, togglefloating"
			"SUPER, R, exec, hyprctl reload"
			"SUPER, F10, exec, pactl set-sink-mute @DEFAULT_SINK@ toggle"	
			"SUPER, F11, exec, pactl set-sink-volume @DEFAULT_SINK@ -5%"
			"SUPER, F12, exec, pactl set-sink-volume @DEFAULT_SINK@ +5%"
			# --- Workspace Switching ---
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
			# --- Move Active Window to Workspace ---
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
			# --- Cycle Workspaces ---
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
      "SUPER, M, movetoworkspace, special"   # send to scratchpad
      "SUPER, N, togglespecialworkspace"     # toggle scratchpad
		];
    description = "List of keybindings for Hyprland.";
  };
}