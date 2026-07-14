{ pkgs, myTheme, ... }:

let
  colors = myTheme.colors;
  ansi = myTheme.toAnsi;

  # Standard escape constants
  bold  = "\\e[1m";
  reset = "\\e[0m";
in
{
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
      
      # Dummy build validation test
      test-rbld = "nix build .#nixosConfigurations.starkiller.config.system.build.toplevel --no-link";
      
      # Modernized 7-day timed cleanups (Wipes profile histories older than 7d, then purges store)
      garbage  = "nix profile wipe-history --older-than 7d && home-manager expire-generations '-7 days' && nix store gc";
      sgarbage = "sudo nix profile wipe-history --profile /nix/var/nix/profiles/system --older-than 7d && sudo nix store gc";
      optimise = "nix store optimise";
      
      # Full wipe aliases
      garbage-all  = "nix profile wipe-history && home-manager remove-generations old && nix store gc";
      sgarbage-all = "sudo nix profile wipe-history --profile /nix/var/nix/profiles/system && sudo nix store gc";
    };
    oh-my-zsh = {
      enable = true;
      theme = "agnoster";
      plugins = [ "git" ];
    };
    initContent = /*zsh*/ ''
      # Full system maintenance
      update-system() {
        echo -e "\n${bold}${ansi colors.cyan1}[1/5] Coaxializing git and tuning flake synchronization variables...${reset}"
        nix flake update

        echo -e "\n${bold}${ansi colors.purple1}[2/5] Harmonizing differential user-space vectors via the home-manager matrix...${reset}"
        home-manager switch --flake .#figs

        echo -e "\n${bold}${ansi colors.blue1}[3/5] Re-calibrating structural NixOS kernel manifolds and deploying base strata...${reset}"
        sudo nixos-rebuild switch --flake .#starkiller --upgrade

        echo -e "\n${bold}${ansi colors.yellow1}[4/5] De-polarizing obsolete generational nodes and de-linking dead GC anchors...${reset}"
        nix profile wipe-history --older-than 7d
        sudo nix profile wipe-history --profile /nix/var/nix/profiles/system --older-than 7d
        home-manager expire-generations "-7 days"
        
        echo -e "${ansi colors.overlay0}>> Phase-shifting unreferenced store payloads out of block storage...${reset}"
        nix store gc
        sudo nix store gc

        echo -e "\n${bold}${ansi colors.pink1}[5/5] Compacting file-system inode geometry and de-duplicating hash registries...${reset}"
        nix store optimise

        echo -e "\n${bold}${ansi colors.green1}CORE STRATA SECURED: ALL HOST PARADIGMS ARE RENORMALIZED; SINGULARITY ACTUALIZED${reset}\n"
      }
    '';
  };
}
