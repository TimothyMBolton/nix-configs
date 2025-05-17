{ config, pkgs, username, ... }:

let
  isDarwin = pkgs.stdenv.isDarwin;
  isLinux = pkgs.stdenv.isLinux;
in {
  home.username = username;
  home.homeDirectory = if isDarwin then "/Users/${username}" else "/home/${username}";
  home.stateVersion = "24.05";

  home.packages = with pkgs; [
    # --- CLI ---
    git curl wget jq fzf ripgrep bat htop unzip zip tree
    neovim
    nodejs
    python3
    go
    gh                    # GitHub CLI
    direnv
    zoxide
    just
    nixpkgs-fmt

    # --- Browsers ---
    firefox
    google-chrome

    # --- Editors / IDEs ---
    vscode
    jetbrains-toolbox

    # --- Containers ---
    docker

    # --- Media & Utilities ---
    spotify
    _1password
    _1password-cli

    # --- Communication ---
    slack
    discord
    zoom-us
  ];

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    initExtra = ''
      eval "$(zoxide init zsh)"
      eval "$(direnv hook zsh)"
    '';
  };

  programs.git = {
    enable = true;
    userName = "Timothy Bolton";
    userEmail = "tim@example.com";
  };

  home.shellAliases = {
    ll = "ls -la";
    gits = "git status";
    gitl = "git log --oneline";
    nixup = "nix run .#homeConfigurations.timothybolton@${pkgs.system}.activationPackage";
  };
}
