{
  description = "Shared NixOS + Home Manager setup";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
    in {
      nixosConfigurations.starkiller = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/starkiller/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.users.figs = import ./home/figs/home.nix;
            home-manager.users.riley = import ./home/riley/home.nix;
          }
        ];
      };

      # Optional: makes `nix build .#starkiller` work
      defaultPackage.${system} = self.nixosConfigurations.starkiller.config.system.build.toplevel;
    };

}
