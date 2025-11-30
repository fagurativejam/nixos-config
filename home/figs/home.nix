{ config, pkgs, ... }:

{
  imports = [
    ../../modules/hyprland-home.nix
    ../../modules/wezterm.nix
  ];

  # ┌───────────────────────────────┐
  # │ 🖥️ Desktop Modules            │
  # └───────────────────────────────┘
  my.desktop = {
    wezterm.config = ./wezterm.lua;
    hyprland.enable = true;
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

      # Fonts
      nerd-fonts.fira-code
      nerd-fonts.jetbrains-mono
      nerd-fonts.hack
      nerd-fonts.iosevka
      nerd-fonts.sauce-code-pro
      nerd-fonts.dejavu-sans-mono
      nerd-fonts.ubuntu-mono
      nerd-fonts.droid-sans-mono

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
  # │ 🔤 Fonts                      │
  # └───────────────────────────────┘
  fonts.fontconfig.enable = true;

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
        rebuild = "sudo nixos-rebuild switch --flake .#starkiller";
        update = "nix flake update";
      };
    };

    # Zsh (primary shell)
    zsh = {
      enable = true;

      syntaxHighlighting.enable = true;
      autosuggestion.enable = true;

      shellAliases = {
        hm = "nix run .#home-manager --";
        rebuild = "sudo nixos-rebuild switch --flake .#starkiller";
        update = "nix flake update";
      };

      oh-my-zsh = {
        enable = true;
        theme = "agnoster"; # or "powerlevel10k" if installed
        plugins = [
          "git"
          "zsh-autosuggestions"
          "zsh-syntax-highlighting"
        ];
      };
    };

    # Enable Home Manager itself
    home-manager.enable = true;
  };
}
