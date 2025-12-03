{
  description = "My NixOS setup with Home Manager";

  inputs = {
    nixpkgs.url = "github:Nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ...}:
    {
      nixosConfigurations.starkiller = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/starkiller/starkiller.nix
          ./hosts/starkiller/starkiller-hardware.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.figs = import ./users/figs/figs.nix;
          }
        ];
      };
      homeConfigurations.figs = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs { 
          system = "x86_64-linux"; 
          config.allowUnfree = true;
        };
        modules = [ ./users/figs/figs.nix ];
      };
    };

}