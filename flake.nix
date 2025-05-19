{
  description = "NixOS and Darwin System Configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, darwin }: {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          (self + "/modules/shared/common.nix")  # Use explicit path
          (self + "/hosts/nixos/configuration.nix")
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.timothybolton = import (self + "/home");
          }
        ];
      };
    };

    darwinConfigurations = {
      macbook = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          (self + "/modules/shared/common.nix")  # Use explicit path
          (self + "/hosts/darwin/configuration.nix")
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.timothybolton = import (self + "/home");
          }
        ];
      };
    };
  };
}