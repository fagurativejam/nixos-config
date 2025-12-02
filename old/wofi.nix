{ config, pkgs, lib, ... }:

{
  options = {
    my.desktop.wofi.enable =
      lib.mkEnableOption "Enable Wofi launcher for user";
  };

  config = lib.mkIf config.my.desktop.wofi.enable {
    programs.wofi.enable = true;

    home.file.".config/wofi/config".text = ''
      show=drun
      prompt=Run:
      allow-images=true
      hide-scroll=true
      insensitive=true
      term=foot
    '';

    home.file.".config/wofi/style.css".text = ''
      window {
        background-color: rgba(46, 52, 64, 0.9); /* semi-transparent */
        border: 2px solid rgba(76, 86, 106, 0.8);
        border-radius: 8px;
        box-shadow: 0px 6px 18px rgba(0,0,0,0.45); /* subtle shadow */
      }

      #input {
          margin: 8px;
          padding: 6px;
          border-radius: 6px;
          background-color: rgba(59, 66, 82, 0.85);
          color: #D8DEE9;
      }

      #inner-box {
          margin: 8px;
          padding: 6px;
          background-color: rgba(59, 66, 82, 0.75);
          border-radius: 6px;
      }

      #outer-box {
          margin: 8px;
          padding: 6px;
          background-color: rgba(46, 52, 64, 0.6);
          border-radius: 6px;
      }

      #scroll {
          margin: 4px;
          padding: 4px;
      }

      #text {
          color: #ECEFF4;
      }

      #entry {
          border-radius: 4px;
          transition: background-color 0.2s ease, color 0.2s ease;
      }

      #entry:hover {
          background-color: rgba(94, 129, 172, 0.4); /* hover highlight */
          color: #ECEFF4;
      }

      #entry:selected {
          background-color: rgba(94, 129, 172, 0.8);
          color: #ECEFF4;
          border-radius: 6px;
      }
    '';
  };
}
