{
  description = "NixOS + Home Manager setup for starkiller and figs";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
    in {
      # --- Main host configuration ---
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

      # --- Installer ISO configuration ---
      nixosConfigurations.install-iso = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          # Reuse your system config (but NOT hardware)
          ./hosts/starkiller/starkiller.nix

          # ✅ Properly import the installer ISO module from nixpkgs input
          (import "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix")

          home-manager.nixosModules.home-manager
          {
            # Avoid broken ZFS by explicitly listing supported filesystems
            boot.supportedFilesystems = [ "btrfs" "xfs" "ext4" ];

            environment.systemPackages = with nixpkgs.legacyPackages.${system}; [
              git vim parted
            ];
          }
        ];
      };

      # --- Expose ISO as a top-level package ---
      packages.${system}.install-iso =
        self.nixosConfigurations.install-iso.config.system.build.isoImage;

      # --- Home Manager standalone config ---
      homeConfigurations.figs = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
        modules = [ ./users/figs/figs.nix ];
      };
    };
}
