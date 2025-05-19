{ config, pkgs, ... }: {
  home.username = "timothybolton";
  home.homeDirectory = "/home/timothybolton";
  home.stateVersion = "24.11";

  programs.home-manager.enable = true;
}