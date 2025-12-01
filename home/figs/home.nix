{ config, pkgs, ... }:

{
  imports = [
    ../../modules/hypr/hyprland.nix
    ../../modules/termina/wezterm.nix
    ../../modules/waybar.nix
    ../../modules/terminal/terminal.nix
    ../../modules/wofi.nix
    ../../modules/terminal/fastfetch.nix
  ];

  # ┌───────────────────────────────┐
  # │ 🖥️ Desktop Modules            │
  # └───────────────────────────────┘
  my.desktop = {
    wezterm.config = ./wezterm.lua;
    hyprland.enable = true;
    terminal = {
      enable = true;
      defaultTerminal = "wezterm";
    };
  };

  # ┌───────────────────────────────┐
  # │ 👤 Home Manager User Config   │
  # └───────────────────────────────┘
  home = {
    username = "figs";
    homeDirectory = "/home/figs";
    stateVersion = "25.05";
    enableNixpkgsReleaseCheck = false;

    packages = with pkgs; [
      # Gaming / Communication
      discord

      # Productivity
      wezterm
      libreoffice
      vscode

      # Extra desktop tools
      grimblast    # screenshot tool
      slurp        # region selection screenshots
      light        # brightness control
      playerctl    # commandline media controls
      mako         # notification daemon
      hyprpaper    # wallpaper daemon 
      wl-clipboard # wayland clipboard utility
      fastfetch
      htop
    ];
  };

  # ┌───────────────────────────────┐
  # │ ⚙️ Programs & Shells          │
  # └───────────────────────────────┘
  programs = {
    # Git configuration
    git = {
      enable = true;
      settings = {
        user.name = "fagurativejam";
        user.email = "fagurativejam@proton.me";
      };
    };

    # Bash (optional, keep only if you use Bash)
    bash = {
      enable = true;
      shellAliases = {
        hm = "nix run .#home-manager --";
        hmrbld = "nix run .#home-manager -- switch --flake .#figs";
        rebuild = "sudo nixos-rebuild switch --flake .#starkiller";
        update = "nix flake update";
      };
    };

    # Enable Home Manager itself
    home-manager.enable = true;
  };
}
