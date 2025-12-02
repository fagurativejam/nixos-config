{ lib, config, ... }:

{
  options.my.desktop.wofi.enable =
    lib.mkEnableOption "Enable Wofi application launcher";

  config = lib.mkIf config.my.desktop.wofi.enable {
    programs.wofi.enable = true;
  };
}
