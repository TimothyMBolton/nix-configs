# Justfile for Timothy Bolton's Nix dev environment

# Use this if you want the tasks to be portable
set shell := ["bash", "-cu"]

# Default target
default:
    just --summary

# 🆕 Clone and set up a new machine from this repo
bootstrap:
    nix run .#homeConfigurations.timothybolton@$(nix eval --impure --raw --expr builtins.currentSystem).activationPackage

# 🚀 Rebuild Home Manager config
nixup:
    nix run .#homeConfigurations.timothybolton@$(nix eval --impure --raw --expr builtins.currentSystem).activationPackage

# 🧪 Enter default dev shell
develop:
    nix develop

# 📦 Update flake inputs
update:
    nix flake update

# 🔍 Show flake inputs
inputs:
    nix flake show

# 🧹 Clean up unused store paths
clean:
    nix store gc

# ✂️ Format Nix code (requires nixpkgs-fmt or nixfmt in your home.packages)
fmt:
    nix fmt || echo "No formatter installed (try adding nixpkgs-fmt)"

# 🐒 Git status
status:
    git status
