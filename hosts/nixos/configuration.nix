{ config, pkgs, ... }:

{
  imports = [ 
    ./hardware-configuration.nix
  ];

  # Bootloader configuration
  boot.loader.grub = {
    enable = false;
    efiSupport = true;
    device = "nodev";
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Basic system configuration
  networking.hostName = "nixos";
  time.timeZone = "Australia/Sydney";

  # Locale settings
  i18n.defaultLocale = "en_AU.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_AU.UTF-8";
    LC_IDENTIFICATION = "en_AU.UTF-8";
    LC_MEASUREMENT = "en_AU.UTF-8";
    LC_MONETARY = "en_AU.UTF-8";
    LC_NAME = "en_AU.UTF-8";
    LC_NUMERIC = "en_AU.UTF-8";
    LC_PAPER = "en_AU.UTF-8";
    LC_TELEPHONE = "en_AU.UTF-8";
    LC_TIME = "en_AU.UTF-8";
  };

  # Printing support
  services.printing.enable = true;

  # Audio configuration
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # User account
  users.users.timothybolton = {
    isNormalUser = true;
    description = "timothybolton";
    extraGroups = [ "wheel" "networkmanager" ];
    packages = with pkgs; [ kitty ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Hyprland and Wayland session setup
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # Use greetd as a minimal Wayland-compatible display manager
  services.greetd = {
    enable = true;
    settings.default_session = {
      command = "Hyprland";
      user = "timothybolton";
    };
  };

  # System packages
  environment.systemPackages = with pkgs; [
    vim
    wget
    vscode
    neovim
    git
    tree
    kitty
    firefox
    google-chrome
    waybar
    rofi-wayland
    swww
    dunst
  ];

  system.stateVersion = "23.11";
}
