{ config, pkgs, ... }:

{
  networking = {
    # Hostname can be overridden per host in configuration.nix
    firewall.enable = true;

    # Use NetworkManager for Wi-Fi/Ethernet
    networkmanager.enable = true;
  };
}
