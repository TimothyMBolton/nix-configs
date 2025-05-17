{
  description = "Tim's Macbook Pro Setup";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      supportedSystems = [ "aarch64-darwin" "x86_64-linux" ];
    in
    {
      homeConfigurations = builtins.listToAttrs (map (system:
        let
          username = "timothybolton";
          pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };

        in {
          name = "${username}@${system}";
          value = home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            modules = [
              ./home.nix
              (if pkgs.stdenv.isDarwin then ./darwin.nix else ./linux.nix)
            ];
            extraSpecialArgs = { inherit username; };
          };
        }
      ) supportedSystems);
    };
}
