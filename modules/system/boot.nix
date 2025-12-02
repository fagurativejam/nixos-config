{ config, pkgs, ... }:

{

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
}