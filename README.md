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

---

## 🖥️ System Configuration (`configuration.nix`)

Machine‑wide settings and services:
- Bootloader (GRUB + EFI)
- Kernel (`linuxPackages_latest`)
- Networking (firewall, NetworkManager)
- Locale & time zone
- Display managers (SDDM, Plasma, Hyprland session)
- Audio stack (PipeWire + rtkit)
- Services (printing, SSH, auto‑update timer)
- Users (`figs`, `riley`) with Zsh as login shell
- Graphics drivers + Vulkan tools
- Programs needing system integration (Steam, Firefox, Zsh)
- Core CLI tools (`wget`, `git`)
- Nix settings (flakes + nix‑command)
- State version pinned to `25.05`

---

## 👤 User Environment (`home.nix`)

User‑specific tools and preferences:
- Imports: Hyprland + WezTerm modules
- Packages: Discord, LibreOffice, VSCode, fonts, desktop utilities (grimblast, slurp, mako, hyprpaper, wl‑clipboard, fastfetch, htop)
- Fonts: Nerd Fonts with fontconfig enabled
- Git: user identity configured
- Shells:
  - Zsh with Oh‑My‑Zsh, autosuggestions, syntax highlighting, aliases
  - Bash aliases (optional)
- Home Manager enabled

---

## 🖥️ Desktop Experience (`hyprland-home.nix`)

Window manager and desktop services:
- Hyprland WM enabled with:
  - Monitor setup
  - Exec‑once apps (Waybar, Mako, CopyQ)
  - Keybindings (imported from `keybindings.nix`)
  - Animations + custom bezier curves
  - Window rules (float specific apps)
- Services:
  - Hyprpaper (wallpaper daemon)
  - Mako (notifications)
- Programs:
  - Rofi (launcher)
  - Waybar (status bar with Nord theme, modules for workspaces, tray, audio, CPU, memory, clock)

---

## 🔄 Usage

Rebuild system: sudo nixos-rebuild switch --flake .#'host'
Update flake inputs: nix flake update
Apply Home Manager changes: nix run .#home-manager -- switch .#'user'

