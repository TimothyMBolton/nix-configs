{ config, pkgs, ... }:

{
  # Basic system configuration
  networking.hostName = "macbook";
  
  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  # Packages to install
  environment.systemPackages = with pkgs; [
    vim
    git
  ];

  # Used for backwards compatibility
  system.stateVersion = 4;
}