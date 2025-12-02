{ config, pkgs, ... }:

{
  imports = [
    ../../modules/home/git.nix
    ../../modules/home/terminal.nix
    ../../modules/home/wofi.nix
    ../../modules/home/hypr/hyprland.nix
    ../../modules/home/waybar/waybar.nix
    ../../modules/home/wezterm/wezterm.nix
  ];

  my.desktop = {
    wezterm.enable = true;
    hyprland.enable = true;
    waybar.enable = true;
    terminal = {
      enable = true;
      defaultTerminal = "wezterm";
    };
  };

  home = {
    username = "figs";
    homeDirectory = "/home/figs";
    stateVersion = "25.05";
    enableNixpkgsReleaseCheck = false;

    packages = with pkgs; [
      discord
      wezterm
      libreoffice
      vscode
      grimblast
      slurp
      light
      playerctl
      mako
      hyprpaper
      wl-clipboard
      hyfetch
      fastfetch
      htop
      cava
      fortune
      cowsay
    ];
  };

  programs = {
    bash = {
      enable = true;
      shellAliases = {
        hm = "nix run .#home-manager --";
        hmrbld = "nix run .#home-manager -- switch --flake .#figs";
        rebuild = "sudo nixos-rebuild switch --flake .#starkiller";
        update = "nix flake update";
      };
    };

    home-manager.enable = true;
  };
}
