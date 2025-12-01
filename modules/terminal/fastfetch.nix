{ lib, config, pkgs, ... }:

{
  options.my.desktop.fastfetch.enable =
    lib.mkEnableOption "Enable Fastfetch with Dracula/Tokyo Night config";

  config = lib.mkIf config.my.desktop.fastfetch.enable {
    # Install fastfetch
    home.packages = [ pkgs.fastfetch ];

    # Drop in your custom config.jsonc
    home.file.".config/fastfetch/config.jsonc".text = ''
      {
        "logo": {
          "source": "auto",
          "color": "magenta"
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
  };
}