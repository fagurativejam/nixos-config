{
  description = "Figs' Buckwild Starkiller Hyprland Rice (patent pending)TM";

  inputs = {
    nixpkgs.url = "github:Nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ...}@inputs: let
    #Shared base config for all x86_64-linux outputs
    system = "x86_64-linux";

    #Global nixpkgs config
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree= true; #Allow unfree packages (for firmware, etc)
    };

  in {
    #NixOS system configuration for starkiller
    nixosConfigurations.starkiller = nixpkgs.lib.nixosSystem {
      inherit system;

      #Makes flake inputs/outputs available as specialArgs in all modules
      specialArgs = {inherit inputs self; };

      modules =[
        #Hardware + host config 
        ./hosts/starkiller/starkiller.nix
        ./hosts/starkiller/starkiller-hardware.nix

        #Home-Manager as NixOS module (integrates user config into system)
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true; #Use system pkgs instead of per-user
            useUserPackages = true; #Install user packages to ~/.nix-profile
            extraSpecialArgs = {inherit inputs self; }; #Pass flake to HM too
            users.figs = import ./users/figs/figs.nix;
          };

          nixpkgs.config.allowUnfree = true;
        }
      ];
    };

    #Standalone Home-Manager configuration
    #Useful for when wanting to test/rebuild user config without touching system
    homeConfigurations.figs = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;

      #same specialArgs as system so modules behave consistently
      extraSpecialArgs = { inherit inputs self; };

      modules = [
        ./users/figs/figs.nix
      ];
    };
  };
}