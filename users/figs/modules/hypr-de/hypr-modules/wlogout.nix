{ config, lib, myTheme, ... }:

let
  colors = myTheme.colors;
  rgba = myTheme.toRGBACss;
in
{
  config = lib.mkIf config.my.hyprland.enable {
    programs.wlogout = {
      enable = true;
      layout = [
        {
          label = "lock";
          action = "hyprlock";
          text = "󰌾 Lock: l";
          keybind = "l";
        }
        {
          label = "suspend";
          action = "systemctl suspend";
          text = "󰤄 Suspend: u";
          keybind = "u";
        }
        {
          label = "logout";
          action = "hyprctl dispatch exit 0";
          text = "󰍃 Logout: e";
          keybind = "e";
        }
        {
          label = "reboot";
          action = "systemctl reboot";
          text = "󰜉 Reboot: r";
          keybind = "r";
        }
        {
          label = "shutdown";
          action = "systemctl poweroff";
          text = "󰐥 Shutdown: s";
          keybind = "s";
        }
      ];
      style = /*lua*/ ''
        window {
          background-color: ${rgba colors.bg "0.9"}; 
        }
        /* Button */
          button {
            font-family: "JetBrains Mono Nerd Font";
            font-size: 20px;
            font-weight: bold;
            color: ${rgba colors.white "1"}; 
            background-color: ${rgba colors.surface0 "0.8"}; 
            border: 2px solid ${rgba colors.surface2 "0.9"};  
            border-radius: 12px;
            margin: 15px;
            transition: all 0.2s ease-in-out;
            opacity: 0.8;
            background-repeat: no-repeat;
            background-position: center;
            background-image: none;
          }
        /* Generic Hover/Focus state */
          button:focus, button:hover {
            background-color: ${rgba colors.blue1 "0.8"}; 
            border: 2px solid ${rgba colors.surface2 "0.9"};
            color: ${rgba colors.white "1"};
          }
        /* Specific Shutdown ID override */
          #shutdown:focus, #shutdown:hover {
            background-color: ${rgba colors.red2 "0.8"};
            border: 2px solid ${rgba colors.porsche "0.9"};
            color: ${rgba colors.white "1"};
          }
      '';
    };
  };
}
