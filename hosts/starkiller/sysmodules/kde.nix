{ config, lib, pkgs, ...}:
{
  options.my.kde = {
    enable = lib.mkEnableOption "Enable KDE Plasma 6";
  };

  config = lib.mkIf config.my.kde.enable {
    services = {
      desktopManager.plasma6.enable = true;
      displayManager.sddm.enable = true;
    };

    environment.plasma6.excludePackages = with pkgs.kdePackages; [
      kate
      konsole
      qrca
    ];
  };
}