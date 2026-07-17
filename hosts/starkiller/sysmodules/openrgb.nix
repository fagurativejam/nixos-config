# openrgb.nix
{ pkgs, ... }: {

  # 1. Enable Native I2C infrastructure
  hardware.i2c.enable = true;

  # 2. Force load the driver modules OpenRGB requires for AMD Zen chipsets
  boot.kernelModules = [ "i2c-dev" "i2c-piix4" ];

  # 3. CRITICAL FOR AMD RAM: Force the kernel to unblock the SMBus controller
  boot.kernelParams = [ "acpi_enforce_resources=lax" ];

  # 4. Add debugging tools to the system environment
  environment.systemPackages = [ pkgs.i2c-tools ];

  # 5. Configure the system-level OpenRGB service
  services.hardware.openrgb = {
    enable = true;
    motherboard = "amd";
    package = pkgs.openrgb-with-all-plugins;
    startupProfile = "default"; 
  };

  # 6. Automatically append common AMD permissions rules for USB controllers
  services.udev.extraRules = ''
    SUBSYSTEMS=="usb|hidraw", ATTRS{idVendor}=="1002", TAG+="uaccess"
  '';
}
