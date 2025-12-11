{
  description = "My NixOS setup with Home Manager";

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

      nixosConfigurations.install-iso = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/starkiller/starkiller.nix
          home-manager.nixosModules.home-manager
          {
            environment.systemPackages = with nixpkgs.legacyPackages.${system}; [
              git vim parted
            ];
          }
        ];
      };

      # 👇 expose the ISO image as a top-level package
      packages.${system}.install-iso = self.nixosConfigurations.install-iso.config.system.build.isoImage;

      homeConfigurations.figs = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
        modules = [ ./users/figs/figs.nix ];
      };
    };
}
