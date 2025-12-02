{ config, lib, pkgs, ... }:

{
  options.my.desktop.wofi.enable =
    lib.mkEnableOption "Enable Wofi application launcher";

  config = lib.mkIf config.my.desktop.wofi.enable {
    programs.wofi = {
      enable = true;

      # Pull in settings and style from separate files
      settings = import ./settings.nix;
      style = builtins.readFile ./style.css;
    };
  };
}
