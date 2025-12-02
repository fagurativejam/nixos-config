{
  description = "Shared NixOS + Home Manager setup";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in {
      nixosConfigurations = {
        starkiller = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/starkiller/configuration.nix
            ./hosts/starkiller/hardware-configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users = {
                figs  = import ./home/figs/home.nix;
                riley = import ./home/riley/home.nix;
              };
            }
          ];
        };
      };

      homeConfigurations = {
        figs = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./home/figs/home.nix ];
        };

        riley = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./home/riley/home.nix ];
        };
      };

      apps.x86_64-linux.home-manager = {
        type = "app";
        program = "${home-manager.packages.x86_64-linux.home-manager}/bin/home-manager";
      };
    };
}
