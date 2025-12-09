{ config, pkgs, ... }:

{
  networking = {
    hostName = "starkiller";
    firewall.enable = true;
    firewall.allowedTCPPorts = [ 25565 ];
    networkmanager.enable = true;
  };

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
    greetd
    tuigreet
  ];

  programs = { 
    steam.enable = true;
    hyprland.enable = true;
    zsh.enable = true;
  };

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet \
          --time \
          --asterisks \
          --remember \
          --cmd ${pkgs.hyprland}/bin/Hyprland";
        user = "greeter";
      };

      sessions = [
        {
          name = "tty";
          command = "${pkgs.bash}/bin/bash";
          user = "root";
        }
      ];
    };
  };

  services.udev.enable = true;        # device management
  services.udisks2.enable = true;     # automount disks

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
