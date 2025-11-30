{ config, pkgs, ... }:

{
  # ┌───────────────────────────────┐
  # │ 🚀 Bootloader & Kernel        │
  # └───────────────────────────────┘
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

  # ┌───────────────────────────────┐
  # │ 🌐 Networking                 │
  # └───────────────────────────────┘
  networking = {
    hostName = "starkiller";
    firewall.enable = true;
    networkmanager.enable = true; # Use NetworkManager for Wi-Fi/Ethernet
  };

  # ┌───────────────────────────────┐
  # │ 🕑 Locale & Time              │
  # └───────────────────────────────┘
  time.timeZone = "America/Chicago";
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      # All set to en_US.UTF-8
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

  # ┌───────────────────────────────┐
  # │ 🖥️ Display & Desktop          │
  # └───────────────────────────────┘
  services = {
    # X server basics
    xserver = {
      enable = true;
      xkb.layout = "us";
    };

    # Display managers & sessions
    displayManager.defaultSession = "hyprland"; # Boot into Hyprland by default
    displayManager.sddm.enable = true;
    desktopManager.plasma6.enable = true;       # KDE Plasma available

    # Audio stack
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    # Other services
    printing.enable = true; # CUPS printing
    openssh.enable = true;  # SSH server
  };

  # ┌───────────────────────────────┐
  # │ 📦 Programs(system-integrated)│
  # └───────────────────────────────┘
  programs = {
    hyprland.enable = true; # Hyprland WM
    firefox.enable = true;  # Desktop integration for Firefox
    steam.enable = true;    # Steam runtime + 32-bit libs
    zsh.enable = true;      # Proper login shell support
  };

  # ┌───────────────────────────────┐
  # │ 🔒 Audio / Security           │
  # └───────────────────────────────┘
  security.rtkit.enable = true; # Needed for PipeWire real-time scheduling

  # ┌───────────────────────────────┐
  # │ 👥 Users                      │
  # └───────────────────────────────┘
  users.users = {
    # Primary user
    figs = {
      isNormalUser = true;
      description = "Fig Jam";
      shell = pkgs.zsh;
      extraGroups = [ "networkmanager" "wheel" ];
    };

    # Secondary user
    riley = {
      isNormalUser = true;
      description = "Riley";
      extraGroups = [ "networkmanager" "wheel" ];
    };
  };

  # ┌───────────────────────────────┐
  # │ 🎨 Graphics                   │
  # └───────────────────────────────┘
  
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      vulkan-loader
      vulkan-tools
      vulkan-validation-layers # Debugging/validation tools
    ];
  };

  # ┌───────────────────────────────┐
  # │ 📦 System Packages            │
  # └───────────────────────────────┘
  environment.systemPackages = with pkgs; [
    wget
    git
  ];

  # ┌───────────────────────────────┐
  # │ 🔤 Fonts                      │
  # └───────────────────────────────┘
  fonts = {
    fontconfig.enable = true;
    packages = with pkgs; [
      pkgs.nerd-fonts.fira-code
      pkgs.nerd-fonts.jetbrains-mono
      pkgs.nerd-fonts.hack
      pkgs.nerd-fonts.iosevka
      pkgs.nerd-fonts.sauce-code-pro
      pkgs.nerd-fonts.dejavu-sans-mono
      pkgs.nerd-fonts.ubuntu-mono
      pkgs.nerd-fonts.droid-sans-mono
      pkgs.nerd-fonts.symbols-only
    ];
  };


  # ┌───────────────────────────────┐
  # │ ⚙️ Nix Settings               │
  # └───────────────────────────────┘
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # ┌───────────────────────────────┐
  # │ 🔄 Auto Update Service/Timer  │
  # └───────────────────────────────┘
  systemd.services.nixos-flake-update = {
    description = "Auto update NixOS using flakes";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = ''
        ${pkgs.nixos-rebuild}/bin/nixos-rebuild switch --flake /etc/nixos#starkiller --upgrade
      '';
    };
  };

  systemd.timers.nixos-flake-update = {
    description = "Run NixOS flake update daily";
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "daily";
      Persistent = true;
    };
  };

  # ┌───────────────────────────────┐
  # │ 🗓️ State Version              │
  # └───────────────────────────────┘
  system.stateVersion = "25.05"; # Do not change once set
}
