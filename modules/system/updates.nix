{ config, pkgs, ... }:

{
  systemd.services.nixos-flake-update = {
    description = "Auto update NixOS using flakes";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = ''
        ${pkgs.nixos-rebuild}/bin/nixos-rebuild switch --flake /etc/nixos#${config.networking.hostName} --upgrade
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
}
