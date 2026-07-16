{ config, inputs, lib, pkgs, ... }:

{

  imports = [
    ./sysmodules/hypr-starkiller.nix
  ];

  my.hyprland.enable = true;

  boot = {
    loader = {
      grub = {
        enable = true;
        devices = [ "nodev" ]; # Install GRUB to the EFI partition, not the MBR
        efiSupport = true;
        useOSProber = true; # Detect other OSes for dual-booting
      };
      timeout = 5; # Shorten GRUB timeout for faster booting

      efi = {
        efiSysMountPoint = "/boot"; # Mount EFI system partition at /boot
        canTouchEfiVariables = true; # Allow NixOS to update EFI variables for bootloader
      };
    };
    kernelPackages = pkgs.linuxPackages_latest; # Use latest Linux kernel for best hardware support
  };

  hardware = {
    graphics = {
      enable = true; # Enable graphics drivers
      enable32Bit = true; # Enable 32-bit graphics support for older games
    };
    bluetooth.enable = true;
  };

  networking = {
    hostName = "starkiller";
    networkmanager.enable = true;

    firewall = {
      enable = true;
    };
  };

  users.users.figs = {
    isNormalUser = true;
    description = "Fig Jam";
    shell = pkgs.zsh; # Use Zsh as default shell
    extraGroups = [ "networkmanager" "wheel" "video" "audio" ]; # Add user to necessary groups
  };

  time.timeZone = "America/Chicago"; # Set your local timezone

  xdg = {
    portal = {
      enable = true; # Enable XDG portals for sandboxed applications
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk # Portal backend for GTK applications
      ];
      config.common.default = "*";
    };
    mime.enable = true;
  };

  programs = {
    steam.enable = true; # Enable Steam for gaming
    zsh.enable = true; # Enable Zsh shell
  };

  services = {
    gvfs.enable = true; # Enable GVfs for trash, network shares, and removable device mounting
    tumbler.enable = true; # Enable Thumbnailing service
    udisks2.enable = true; # Enable udisks2 for automounting disks
    openssh.enable = true; # Enable OpenSSH server for remote access
    pipewire = {
      enable = true; # Use PipeWire for audio
      alsa.enable = true; # Enable ALSA support
      alsa.support32Bit = true; # Enable 32-bit ALSA support for older games
      pulse.enable = true; # Enable PulseAudio compatibility layer
    };
    pulseaudio.enable = false; # Disable PulseAudio since we're using PipeWire
  };

  fonts = {
    fontconfig.enable = true; # Enable fontconfig for managing fonts
    packages = with pkgs; [
      nerd-fonts.fira-code # Fira Code Nerd Font for programming
      nerd-fonts.jetbrains-mono # JetBrains Mono Nerd Font for programming
      nerd-fonts.symbols-only # Symbols Only Nerd Font for icons and glyphs
    ];
  };

  environment.systemPackages = with pkgs; [
    home-manager # Include Home Manager for user configuration management
  ];

  environment.sessionVariables = {
    NIXOS_OZONE_HWP = "1";
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";
  };

  nix.package = inputs.nix-monitored.packages.${pkgs.stdenv.hostPlatform.system}.default;

  nixpkgs.overlays = [
    (self: super: {
      nixos-rebuild = super.nixos-rebuild.override {
        nix = inputs.nix-monitored.packages.${super.stdenv.hostPlatform.system}.default;
      };
      nix-direnv = super.nix-direnv.override {
        nix = inputs.nix-monitored.packages.${super.stdenv.hostPlatform.system}.default;
      };
    })
    
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ]; # Enable experimental features for Nix

  system.stateVersion = "25.05"; # match your NixOS release
}
