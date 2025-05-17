{
  description = "Tim's Macbook Pro Setup";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

outputs = { self, nixpkgs, home-manager, flake-utils, ... }:
let
  supportedSystems = [ "aarch64-darwin" "x86_64-linux" ];
  username = "timothybolton";
in
{
  # Shared homeConfigurations across platforms
  homeConfigurations = builtins.listToAttrs (map (system:
    let
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

  # System-specific outputs
} // flake-utils.lib.eachDefaultSystem (system:
  let
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
  in {
    devShells.default = pkgs.mkShell {
      buildInputs = with pkgs; [ go nodejs python3 just git ];
    };
    formatter = pkgs.nixpkgs-fmt;
  });

}
