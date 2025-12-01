{ config, pkgs, lib, ... }:

{
  # ┌───────────────────────────────┐
  # │ ⚙️ Options                    │
  # └───────────────────────────────┘
  options.my.desktop.wofi.enable =
    lib.mkEnableOption "Enable Wofi launcher for user";

  # ┌───────────────────────────────┐
  # │ 🖥️ Wofi Configuration         │
  # └───────────────────────────────┘
  config = lib.mkIf config.my.desktop.wofi.enable {
    programs.wofi.enable = true;

    # ┌───────────────────────────────┐
    # │ ⚙️ Config file                │
    # └───────────────────────────────┘
    home.file.".config/wofi/config".text = ''
      show=drun
      prompt=Run:
      allow-images=true
      hide-scroll=true
      insensitive=true
      term=foot
    '';

    # ┌───────────────────────────────┐
    # │ 🎨 Style (CSS)                │
    # └───────────────────────────────┘
    home.file.".config/wofi/style.css".text = ''
      window {
          background-color: #2E3440;
          border: 2px solid #4C566A;
          border-radius: 6px;
      }

      #input {
          margin: 8px;
          padding: 6px;
          border-radius: 4px;
          background-color: #3B4252;
          color: #D8DEE9;
      }

      #inner-box {
          margin: 8px;
          padding: 6px;
          background-color: #3B4252;
          border-radius: 4px;
      }

      #outer-box {
          margin: 8px;
          padding: 6px;
          background-color: #2E3440;
      }

      #scroll {
          margin: 4px;
          padding: 4px;
      }

      #text {
          color: #ECEFF4;
      }

      #entry:selected {
          background-color: #5E81AC;
          color: #ECEFF4;
          border-radius: 4px;
      }
    '';
  };
}
