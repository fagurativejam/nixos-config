{ config, pkgs, ... }:

{
  networking.hostName = "starkiller";
  time.timeZone = "America/Chicago";

  services.openssh.enable = true;

  users.users.figs = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # sudo access
  };

  system.stateVersion = "25.05"; # match your NixOS release
}
