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
    in {
      # System-level configs
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

      # User-level configs (nix run .#home-manager -- switch --flake .#'username')
      homeConfigurations = {
        figs = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs { system = "x86_64-linux"; config.allowUnfree = true; };
          modules = [ ./home/figs/home.nix ];
        };

        riley = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs { system = "x86_64-linux"; config.allowUnfree = true; };
          modules = [ ./home/riley/home.nix ];
        };
      };

      # Expose the home-manager CLI as a flake app
      apps.x86_64-linux.home-manager = {
        type = "app";
        program = "${home-manager.packages.x86_64-linux.home-manager}/bin/home-manager";
      };
    };
}
