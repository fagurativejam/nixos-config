{ config, pkgs, ... }:

let
  scaleScript = pkgs.writeShellApplication {
    name = "hypr-scale";
    runtimeInputs = [ pkgs.jq pkgs.libnotify ];
    text = ''
      #!${pkgs.zsh}/bin/zsh

      STEP=0.25
      MIN_SCALE=0.5
      MAX_SCALE=3.0

      FOCUSED=$(hyprctl monitors -j | jq -r '.[] | select(.focused == true) | .name')

      if [[ -z $FOCUSED ]]; then
        echo "No focused monitor found"
        exit 1
      fi

      CURRENT=$(hyprctl monitors -j | jq -r ".[] | select(.name == \"$FOCUSED\") | .scale")

      case "$1" in
        up)
          NEW=$(awk "BEGIN {printf \"%.2f\", $CURRENT + $STEP}")
          (( $(awk "BEGIN {print ($NEW > $MAX_SCALE)}") )) && NEW=$MAX_SCALE
          ;;
        down)
          NEW=$(awk "BEGIN {printf \"%.2f\", $CURRENT - $STEP}")
          (( $(awk "BEGIN {print ($NEW < $MIN_SCALE)}") )) && NEW=$MIN_SCALE
          ;;
        reset|1|1.0)
          NEW=1.0
          ;;
        *)
          echo "Usage: $0 up|down|reset"
          exit 1
          ;;
      esac

      hyprctl keyword monitor "$FOCUSED,preferred,auto,$NEW"

      notify-send "Hyprland Scaling" "Monitor $FOCUSED: $CURRENT → $NEW" --icon=display
    '';
  };
in
{
  wayland.windowManager.hyprland.settings.bind = [
    "SUPER CTRL, plus, exec, ${scaleScript}/bin/hypr-scale up"
    "SUPER CTRL, minus, exec, ${scaleScript}/bin/hypr-scale down"
    "SUPER CTRL, 0, exec, ${scaleScript}/bin/hypr-scale reset"
  ];

  home.packages = [ pkgs.jq pkgs.libnotify ];
}
