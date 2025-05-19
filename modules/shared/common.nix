{ pkgs, ... }: {
  # Common configuration for both NixOS and Darwin
  environment.systemPackages = with pkgs; [
    git
    curl
    wget
    vim
    neovim
    vscode
  ];

  # Common system settings
  nixpkgs.config.allowUnfree = true;
}