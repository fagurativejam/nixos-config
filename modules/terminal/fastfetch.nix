{ lib, config, pkgs, ... }:

{
  options.my.desktop.fastfetch.enable =
    lib.mkEnableOption "Enable Fastfetch with custom ASCII logo";

  config = lib.mkIf config.my.desktop.fastfetch.enable {
    home.packages = [ pkgs.fastfetch ];

    # Install Fastfetch config
    home.file.".config/fastfetch/config.jsonc".text = ''
      {
        "logo": {
          "source": "${config.home.homeDirectory}/.config/fastfetch/logo.txt",
          "color": "bright-magenta"
        },
        "modules": [
          { "type": "os" },
          { "type": "kernel" },
          { "type": "uptime" },
          { "type": "packages" },
          { "type": "shell" },
          { "type": "terminal" },
          { "type": "cpu" },
          { "type": "gpu" },
          { "type": "memory" }
        ],
        "display": {
          "separator": "  ",
          "color": {
            "title": "cyan",
            "value": "white",
            "separator": "purple"
          }
        }
      }
    '';

    # Copy your ASCII art logo into place
    home.file.".config/fastfetch/boobs.txt".source = ./boobs.txt;
  };
}
