{ pkgs, inputs, ... }:

{
  home = {
    username = "figs";
    homeDirectory = "/home/figs";
    stateVersion = "25.05"; # match your NixOS release
  };

  imports = [
    #./modules/vscode.nix
    ./modules/fastfetch.nix
    ./modules/hypr-de/hypr-figs.nix
    ./modules/nixvim.nix
    ./modules/wezterm.nix
  ];

  my.hyprland.enable = true;

  programs = {
    hyfetch.enable = true;
    home-manager.enable = true;
  };

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;
    shellAliases = {
      hmrbld  = "home-manager switch --flake .#figs";
      hm      = "home-manager";
      rbld    = "sudo nixos-rebuild switch --flake .#starkiller";
      upgrade = "sudo nixos-rebuild switch --flake .#starkiller --upgrade";
      update  = "nix flake update";
      sgarbage = "sudo nix-collect-garbage --delete-older-than 7d";
      garbage = "nix-collect-garbage --delete-older-than 7d";
      optimise = "nix-store --optimise";
    };
    oh-my-zsh = {
      enable = true;
      theme = "agnoster" ;
      plugins = [ "git" ];
    };
    initContent = ''
    # Full system maintenance
    update-system() {
      echo "=== Updating flakes ==="
      nix flake update

      echo "=== Updating Home Manager ==="
      home-manager switch --flake .#figs

      echo "=== Updating NixOS (with latest packages) ==="
      sudo nixos-rebuild switch --flake .#starkiller --upgrade

      echo "=== Cleaning up old generations ==="
      nix-collect-garbage --delete-older-than 7d
      sudo nix-collect-garbage --delete-older-than 7d
      home-manager expire-generations "-7 days"

      echo "=== Optimising Nix store ==="
      nix-store --optimise

      echo "=== All done! ==="
    }
  '';
  };
  programs.bash = {
    enable = true;
    shellAliases = {
      hmrbld  = "home-manager switch --flake .#figs";
      hm      = "home-manager";
      rbld    = "sudo nixos-rebuild switch --flake .#starkiller";
      update  = "nix flake update";
    };
  };

  programs.git = {
    enable = true;
    settings = {
      user.name = "fagurativejam";
      user.email = "fagurativejam@proton.me";
    };
  };

  news.display = "silent";

  home.pointerCursor = {
    enable=true;
    gtk.enable = true;
    x11.enable = true;
    name = "catppuccin-mocha-dark-cursors";
    package = pkgs.catppuccin-cursors.mochaDark;
    size = 24;
  };

  home.packages = with pkgs; [
    #terminal utils
      cowsay
      fortune
      bottom
      lf
      cava
      gparted
    #gaming/ entertainment
      discord
      steam
      spotify
      prismlauncher #minecraft official launcer currently busted
    #audio
      playerctl
    #duh
      firefox
      blender
    # File Management Stack
      thunar                  # The core file manager
      thunar-archive-plugin   # Right-click "Extract Here" / "Compress"
      thunar-volman           # Removable device management extensions
      shared-mime-info             # Correctly identifies file types
  ];
}
