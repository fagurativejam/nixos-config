{ pkgs, ... }: {

  services = {
    hardware.openrgb = {
      enable = true;
      motherboard = "amd";
      package = pkgs.openrgb-with-all-plugins;
      startupProfile = "default"; 
    };
    udev.extraRules = ''
      SUBSYSTEMS=="usb|hidraw", ATTRS{idVendor}=="1002", TAG+="uaccess"
    '';
  };

}
