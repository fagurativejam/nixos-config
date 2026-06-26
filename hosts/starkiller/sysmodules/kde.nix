{ config, lib, pkgs, ...}:
{
  options.my.kde = {
    enable = lib.mkEnableOption "Enable KDE Plasma 6";
  };

  config = lib.mkIf config.my.kde.enable {
    services = {
      desktopManager.plasma6.enable = true;
        displayManager.sddm = {
        enable = true;
        wayland.enable = true; # Starts SDDM in a Wayland environment
        # Matches the exact naming signature produced by the override below
        theme = "catppuccin-mocha-mauve";
        package = lib.mkForce pkgs.kdePackages.sddm; # Uses the newer Qt6 wrapper
      };
    };

    environment.plasma6.excludePackages = with pkgs.kdePackages; [
      kate
      konsole
      qrca
      dolphin
      gwenview
      okular
      ark
      elisa
      khelpcenter
      plasma-browser-integration
      oxygen
    ];

    environment.systemPackages = with pkgs; [
      (pkgs.catppuccin-sddm.override {
        flavor = "mocha";
        accent = "mauve";
        font = "Noto Sans";
        fontSize = "11";
        loginBackground = true;
        background = "${../../users/figs/wallpapers/wallpaper-nixos.jpg}";
      })
    ];
  };
}