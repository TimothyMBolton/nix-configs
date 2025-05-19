# List all available commands
default:
    @just --list

# Update flake locks
update:
    nix flake update

# Check flake
check:
    nix flake check

# Build and switch to new NixOS configuration
switch-nixos:
    nixos-rebuild switch --flake .#nixos

# Build and switch to new Darwin configuration
switch-darwin:
    darwin-rebuild switch --flake .#macbook

# Build without switching - NixOS
build-nixos:
    nixos-rebuild build --flake .#nixos

# Build without switching - Darwin
build-darwin:
    darwin-rebuild build --flake .#macbook

# Clean up old generations - NixOS
clean-nixos:
    nix-collect-garbage -d
    nixos-rebuild boot --flake .#nixos

# Clean up old generations - Darwin
clean-darwin:
    nix-collect-garbage -d
    darwin-rebuild boot --flake .#macbook

# Update and switch for the current system
update-system:
    #!/usr/bin/env bash
    if [[ "$(uname)" == "Darwin" ]]; then
        just update && just switch-darwin
    else
        just update && just switch-nixos
    fi