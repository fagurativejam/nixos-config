{ config, pkgs, ... }:

{
  services.openssh = {
    enable = true;

    # Security hardening
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
  };

  # Optional: add ssh client tools
  programs.ssh.startAgent = true;
}
