{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # Bootloader
  boot.loader.grub.enable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.devices = [ "nodev" ];
  boot.loader.grub.useOSProber = true;

  boot.loader.efi.efiSysMountPoint = "/boot";
  boot.loader.efi.canTouchEfiVariables = true;

  boot.loader.grub.efiInstallAsRemovable = false;
  boot.loader.grub.configurationLimit = 5;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Networking
  networking.hostName = "starkiller";
  networking.firewall.enable = true;
  networking.networkmanager.enable = true;

  # Locale & Time
  time.timeZone = "America/Chicago";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Display server & desktop environments
  services.xserver.enable = true;
  services.xserver.xkb.layout = "us";

  services.displayManager.sddm.enable = true;
  services.xserver.displayManager.defaultSession = "hyprland"; # boot into Hyprland by default

  services.desktopManager.plasma6.enable = true; # KDE Plasma available
  programs.hyprland.enable = true;               # Hyprland available

  # Audio
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Printing & SSH
  services.printing.enable = true;
  services.openssh.enable = true;

  # Users
  users.users.figs = {
    isNormalUser = true;
    description = "Fig Jam";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  users.users.riley = {
    isNormalUser = true;
    description = "Riley";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # Programs
  programs.firefox.enable = true;
  programs.steam.enable = true;

  # Graphics
  hardware.graphics.enable = true;

  # System packages
  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    vscode
    fastfetch
    htop
  ];

  # Nix settings
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # State version
  system.stateVersion = "25.05";
}
