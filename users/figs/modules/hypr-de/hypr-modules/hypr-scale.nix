{ config, pkgs, ... }:

let
  scaleScript = pkgs.writeShellApplication {
    name = "hypr-scale";
    runtimeInputs = [ pkgs.jq pkgs.libnotify ];
    text = ''
      #!${pkgs.bash}/bin/bash

      # Safest universal scales (work on almost any resolution)
      SCALES=(0.5 1.0 1.5 2.0 2.5 3.0)

      FOCUSED=$(hyprctl monitors -j | jq -r '.[] | select(.focused == true) | .name')

      if [[ -z $FOCUSED ]]; then
        echo "No focused monitor found"
        exit 1
      fi

      CURRENT=$(hyprctl monitors -j | jq -r ".[] | select(.name == \"$FOCUSED\") | .scale" | awk '{printf "%.2f", $0}')

      case "$1" in
        up|next)
          NEW=$CURRENT
          for s in "''${SCALES[@]}"; do
            if (( $(awk "BEGIN {print ($CURRENT < $s)}") )); then
              NEW=$s
              break
            fi
          done
          [[ "$NEW" == "$CURRENT" ]] && NEW=''${SCALES[0]}
          ;;
        down|prev)
          NEW=$CURRENT
          found=false
          for (( i=''${#SCALES[@]}-1; i>=0; i-- )); do
            s=''${SCALES[i]}
            if (( $(awk "BEGIN {print ($CURRENT > $s)}") )); then
              NEW=$s
              found=true
              break
            fi
          done
          if [[ $found == false ]]; then
            NEW=''${SCALES[-1]}
          fi
          ;;
        reset|1|1.0)
          NEW=1.00
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
    # Increase
    "SUPER ALT, equal, exec, ${scaleScript}/bin/hypr-scale up"
    "SUPER ALT, KP_Add, exec, ${scaleScript}/bin/hypr-scale up"

    # Decrease
    "SUPER ALT, minus, exec, ${scaleScript}/bin/hypr-scale down"
    "SUPER ALT, KP_Subtract, exec, ${scaleScript}/bin/hypr-scale down"

    # Reset to 1.0
    "SUPER ALT, 0, exec, ${scaleScript}/bin/hypr-scale reset"
    "SUPER ALT, KP_0, exec, ${scaleScript}/bin/hypr-scale reset"
  ];

  home.packages = [ pkgs.jq pkgs.libnotify ];
}
