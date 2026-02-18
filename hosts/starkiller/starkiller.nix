{ config, lib, pkgs, ... }:

{
  system.stateVersion = "25.05"; # match your NixOS release

  networking = {
    hostName = "starkiller";
    networkmanager.enable = true;

    firewall = {
      enable = true;
      allowedTCPPorts = [ 25565 ]; # Allow Minecraft server port through firewall
      #allowedUDPPorts = [ 25565 ]; # Uncomment if your Minecraft server uses UDP as well
    };
  };

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

  time.timeZone = "America/Chicago"; # Set your local timezone

  users.users.figs = {
    isNormalUser = true;
    description = "Fig Jam";
    shell = pkgs.zsh; # Use Zsh as default shell
    extraGroups = [ "networkmanager" "wheel" "video" "audio" ]; # Add user to necessary groups
  };

  hardware.graphics = {
    enable = true; # Enable graphics drivers
    enable32Bit = true; # Enable 32-bit graphics support for older games
  };

  services.pipewire = {
    enable = true; # Use PipeWire for audio
    alsa.enable = true; # Enable ALSA support
    alsa.support32Bit = true; # Enable 32-bit ALSA support for older games
    pulse.enable = true; # Enable PulseAudio compatibility layer
  };

  services.pulseaudio.enable = false; # Disable PulseAudio since we're using PipeWire

  xdg.portal = {
    enable = true; # Enable XDG portals for sandboxed applications
    extraPortals = with pkgs; [
      xdg-desktop-portal-wlr # Portal backend for Wayland compositors
      xdg-desktop-portal-gtk # Portal backend for GTK applications
    ];
  };

  programs = {
    steam.enable = true; # Enable Steam for gaming
    hyprland.enable = true; # Enable Hyprland Wayland compositor
    zsh.enable = true; # Enable Zsh shell
  };

  services.greetd = {
    enable = true; # Enable greetd display manager
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet \
          --time \
          --asterisks \
          --remember \
          --cmd ${pkgs.hyprland}/bin/Hyprland"; # Command to start Hyprland session with tuigreet
        user = "greeter"; # Use a dedicated greeter user for the login screen
      };

      tty_session = {
        command = "${pkgs.bash}/bin/bash"; # Command for a fallback TTY session (useful for troubleshooting
        user = "root"; # Run TTY session as root for full system access
      };
    };
  };

  services = {
    udev.enable = true; # Enable udev for device management
    udisks2.enable = true; # Enable udisks2 for automounting disks
    openssh.enable = true; # Enable OpenSSH server for remote access
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ]; # Enable experimental features for Nix

  fonts = {
    fontDir.enable = true; # Enable font directory for custom fonts
    fontconfig.enable = true; # Enable fontconfig for managing fonts
    
    packages = with pkgs; [
      nerd-fonts.fira-code # Fira Code Nerd Font for programming
      nerd-fonts.jetbrains-mono # JetBrains Mono Nerd Font for programming
      nerd-fonts.symbols-only # Symbols Only Nerd Font for icons and glyphs
    ];
  };

  environment.systemPackages = with pkgs; [
    home-manager # Include Home Manager for user configuration management
    tuigreet # Include tuigreet greeter for a customizable login screen
  ];
}

# {
#   networking = {
#     hostName = "starkiller";
#     firewall.enable = true;
#     firewall.allowedTCPPorts = [ 25565 ];
#     networkmanager.enable = true;
#   };

#   boot = {
#     loader = {
#       grub = {
#         enable = true;
#         devices = [ "nodev" ];
#         efiSupport = true;
#         useOSProber = true;
#         efiInstallAsRemovable = false;
#       };
#       efi = {
#         efiSysMountPoint = "/boot";
#         canTouchEfiVariables = true;
#       };
#     };
#     kernelPackages = pkgs.linuxPackages_latest;
#   };

#   time.timeZone = "America/Chicago";

#   services.openssh.enable = true;

#   users.users.figs = {
#     isNormalUser = true;
#     description = "Fig Jam";
#     shell = pkgs.zsh;
#     extraGroups = [ "networkmanager" "wheel" "video" "audio" ];
#   };

#   hardware.graphics = {
#     enable = true;
#     enable32Bit = true;
#   };

#   services.pipewire = {
#     enable = true;
#     alsa.enable = true;
#     alsa.support32Bit = true;
#     pulse.enable = true;
#   };

#   xdg.portal = {
#     enable = true;
#     extraPortals = with pkgs; [
#       xdg-desktop-portal-wlr
#       xdg-desktop-portal-gtk
#     ];
#   };
  
#   environment.systemPackages = with pkgs; [
#     home-manager
#     greetd
#     tuigreet
#   ];

#   programs = { 
#     steam.enable = true;
#     hyprland.enable = true;
#     zsh.enable = true;
#   };

#   services.greetd = {
#     enable = true;
#     settings = {
#       default_session = {
#         command = "${pkgs.tuigreet}/bin/tuigreet \
#           --time \
#           --asterisks \
#           --remember \
#           --cmd ${pkgs.hyprland}/bin/Hyprland";
#         user = "greeter";
#       };

#       sessions = [
#         {
#           name = "tty";
#           command = "${pkgs.bash}/bin/bash";
#           user = "root";
#         }
#       ];
#     };
#   };

#   services.udev.enable = true;        # device management
#   services.udisks2.enable = true;     # automount disks

#   nix.settings = {
#     experimental-features = [ "nix-command" "flakes" ];
#   };

#   nixpkgs.config.allowUnfree = true;

#   fonts = {
#     fontDir.enable = true;
#     fontconfig.enable = true;
#     packages = with pkgs; [
#       pkgs.nerd-fonts.fira-code
#       pkgs.nerd-fonts.jetbrains-mono
#       pkgs.nerd-fonts.symbols-only
#     ];
#   };

#   system.stateVersion = "25.05"; # match your NixOS release
# }
