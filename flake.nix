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
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users = {
                  figs  = import ./home/figs/home.nix;
                  riley = import ./home/riley/home.nix;
                };
              };
            }
          ];
        };
      };
    };
}

