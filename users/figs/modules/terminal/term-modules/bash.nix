{pkgs, ...}:

{
  programs.bash = {
    enable = true;
    shellAliases = {
      hmrbld  = "home-manager switch --flake .#figs";
      hm      = "home-manager";
      rbld    = "sudo nixos-rebuild switch --flake .#starkiller";
      update  = "nix flake update";
    };
  };
}
