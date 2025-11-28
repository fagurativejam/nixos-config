{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # Bootloader
  boot = {
    loader = {
      grub = {
        enable = true;
        efiSupport = true;
        devices = [ "nodev" ];
        useOSProber = true;
        efiInstallAsRemovable = false;
        configurationLimit = 5;
      };
      efi = {
        efiSysMountPoint = "/boot";
        canTouchEfiVariables = true;
      };
    };
    kernelPackages = pkgs.linuxPackages_latest;
  };

  # Networking
  networking = {
    hostName = "starkiller";
    firewall.enable = true;
    networkmanager.enable = true;
  };

  # Locale & Time
  time.timeZone = "America/Chicago";
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
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
  };

  # Display server & desktop environments
  services = {
    xserver = {
      enable = true;
      xkb.layout = "us";
    };
    displayManager.defaultSession = "hyprland"; # boot into Hyprland by default
    displayManager.sddm.enable = true;
    desktopManager.plasma6.enable = true; # KDE Plasma available
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    printing.enable = true;
    openssh.enable = true;
  };

  programs = {
    hyprland.enable = true; # Hyprland available
    firefox.enable = true;
    steam.enable = true;
  };

  # Audio / security
  security.rtkit.enable = true;

  # Users
  users.users = {
    figs = {
      isNormalUser = true;
      description = "Fig Jam";
      extraGroups = [ "networkmanager" "wheel" ];
    };
    riley = {
      isNormalUser = true;
      description = "Riley";
      extraGroups = [ "networkmanager" "wheel" ];
    };
  };

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
