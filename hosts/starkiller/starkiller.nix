{ config, pkgs, ... }:

{
  networking.hostName = "starkiller";
  networking.firewall.enable = true;
  networking.networkmanager.enable = true;

  boot = {
    loader = {
      grub = {
        enable = true;
        devices = [ "nodev" ];
        efiSupport = true;
        useOSProber = true;
        efiInstallAsRemovable = false;
      };
      efi = {
        efiSysMountPoint = "/boot";
        canTouchEfiVariables = true;
      };
    };
    kernelPackages = pkgs.linuxPackages_latest;
  };

  time.timeZone = "America/Chicago";

  services.openssh.enable = true;

  users.users.figs = {
    isNormalUser = true;
    description = "Fig Jam";
    shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" "video" "audio" ];
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
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
    extraPortals = with pkgs; [
      xdg-desktop-portal-wlr
      xdg-desktop-portal-gtk
    ];
  };
  
  environment.systemPackages = with pkgs; [
    home-manager
  ];

  programs.steam.enable = true;
  programs.hyprland.enable = true;
  programs.zsh.enable = true;
  
  services.greetd = {
    enable = true;
    settings.default_session = {
      command = "${pkgs.hyprland}/bin/Hyprland";
      user = "figs";   # your username
    };
  };

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
  };

  nixpkgs.config.allowUnfree = true;

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
