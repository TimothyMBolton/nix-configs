{ config, pkgs, ... }:

{
  home.username = "timothybolton";
  # Add imports if needed
  imports = [ ];

  # System configuration
  nixpkgs.config.allowUnfree = true;

  # Basic system settings
  time.timeZone = "Australia/Sydney";
  i18n.defaultLocale = "en_AU.UTF-8";


  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Audio configuration
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Define default user
  users.users.timothybolton = {
    isNormalUser = true;
    description = "timothybolton";
    extraGroups = [ "wheel" "networkmanager" ];
  };

  # Enable Firefox
  programs.firefox.enable = true;

  # Desktop environment packages
  environment.systemPackages = with pkgs; [
    waybar
    swww
    dunst
    rofi-wayland
    kitty
    google-chrome
    gh
  ];

  # XDG Portal configuration
  xdg.portal = {
    enable = true;
  };

  # System state version
  system.stateVersion = "23.11";
}