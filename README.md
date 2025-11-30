# 🌌 Starkiller Dotfiles

My personal NixOS + Home Manager setup, with Hyprland as the window manager.  
This repo is organized into **three layers**: system configuration, user environment, and desktop experience.

---

## 🗂️ Structure

        ┌─────────────────────────────┐
        │   🖥️ System Configuration   │
        │   configuration.nix         │
        └──────────────┬──────────────┘
                       │
                       │
                       ▼
        ┌───────────────────────────────────────────┐
        │   👤 User Environment (Home Manager)      │
        │   home.nix                                │
        │                                           │
        │   • User packages (Discord, VSCode, etc.) │
        │   • Fonts & fontconfig                    │
        │   • Git identity                          │
        │   • Shell configs (Zsh, aliases, themes)  │
        └──────────────┬────────────────────────────┘
                       │
                       │
                       ▼
        ┌───────────────────────────────────────────┐
        │   🖥️ Desktop Experience (Hyprland)        │
        │   hyprland-home.nix                       │
        │                                           │
        │   • Hyprland WM settings                  │
        │   • Keybindings                           │
        │   • Animations & window rules             │
        │   • Services (Hyprpaper, Mako)            │
        │   • Programs (Waybar, Rofi)               │
        └───────────────────────────────────────────┘


        

## 🔄 Usage

Rebuild system: sudo nixos-rebuild switch --flake .#'host'
Update flake inputs: nix flake update
Apply Home Manager changes: nix run .#home-manager -- switch .#'user'

