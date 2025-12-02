{ config, pkgs, ... }:

{
  services.printing.enable = true;

  # Optional: enable discovery of network printers
  services.avahi = {
    enable = true;
    nssmdns4 = true;
  };

  # Optional: add common drivers
  environment.systemPackages = with pkgs; [
    hplip        # HP printers
    gutenprint   # Generic drivers
  ];
}
