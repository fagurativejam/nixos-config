{ config, pkgs, ... }:

{
imports = [
  ../../modules/system/boot.nix
  ../../modules/system/networking.nix
  ../../modules/system/locale.nix
  ../../modules/system/audio.nix
  ../../modules/system/fonts.nix
  ../../modules/system/graphics.nix
  ../../modules/system/programs.nix
  ../../modules/system/updates.nix
  ../../modules/services/ssh.nix
  ../../modules/services/printing.nix
  ../../modules/desktop/plasma.nix
  ../../modules/desktop/xserver.nix
];

  networking.hostName = "starkiller";

  users.users = {
    figs = {
      isNormalUser = true;
      description = "Fig Jam";
      shell = pkgs.zsh;
      extraGroups = [ "networkmanager" "wheel" ];
    };
    riley = {
      isNormalUser = true;
      description = "Riley";
      shell = pkgs.zsh;
      extraGroups = [ "networkmanager" "wheel" ];
    };
  };

  environment.systemPackages = with pkgs; [ 
    wget 
    git 
    ];

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "25.05";
}
