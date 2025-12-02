{ lib, config, ... }:

{
  options.my.desktop.wezterm = {
    enable = lib.mkEnableOption "Enable WezTerm terminal emulator";

    config = lib.mkOption {
      type = lib.types.path;
      default = ./wezterm.lua;  # default to the lua file in this directory
      description = "Path to wezterm.lua configuration file.";
    };
  };

  config = lib.mkIf config.my.desktop.wezterm.enable {
    programs.wezterm = {
      enable = true;
      extraConfig = builtins.readFile config.my.desktop.wezterm.config;
    };
  };
}
