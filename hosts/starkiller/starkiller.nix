{ config, pkgs, ... }:

{
  networking.hostName = "starkiller";
  networking.firewall.enable = true;
  networking.networkmanager.enable = true;

  boot.loader.grub = {
    enable = true;
    version = 2;
    devices = [ "/dev/nvme0n1p1" ];
  };

  time.timeZone = "America/Chicago";

  services.openssh.enable = true;

  users.users.figs = {
    isNormalUser = true;
    description = "Fig Jam";
    extraGroups = [ "networkmanager" "wheel" "video" "audio" ];
  };

  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
  };

  # hardware.graphics = {
  #   enable = true;
  #   extraPackages = with pkgs; [
  #     vulkan-loader
  #     vulkan-tools
  #     vulkan-validation-layers 
  #   ];
  # };

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ 
      pkgs.xdg-desktop-portal-gtk  
      pkgs.xdg-desktop-portal-wlr 
    ];
  };

  programs.steam.enable = true;

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
  };

  fonts = {
    fontDir.enable = true;
    fontconfig.enable = true;
    packages = with pkgs; [
      pkgs.nerd-fonts.fira-code
      pkgs.nerd-fonts.jetbrains-mono
      pkgs.nerd-fonts.symbols-only
    ];
  };

  system.stateVersion = "25.05"; # match your NixOS release
}
