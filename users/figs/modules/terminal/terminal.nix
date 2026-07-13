{pkgs, ...}:
{
  imports = [
    ./term-modules/fastfetch.nix
    ./term-modules/nixvim.nix
    ./term-modules/wezterm.nix
  ];
  programs = {
    hyfetch.enable=true;
  }:
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
    initContent =/*zsh*/ ''
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
  home.packages = with pkgs [
    #terminal utils
      cowsay
      fortune
      bottom
      lf
      cava
  ];
}
