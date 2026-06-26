# /home/figs/Bullshit/users/figs/modules/palette.nix
let
  # --- Core Design Tokens (Raw Hex Strings) ---
  colors = {
    # Catppuccin Mocha Architecture (Main Frame & Apps)
    bgMain        = "1e1e2e"; # Mocha Base (Default dark background)
    bgCrust       = "11111b"; # Mocha Crust (Deep contrast for inputs/bars)
    surface       = "313244"; # Surface0 (Cards, active panels, text boxes)
    surfaceMuted  = "45475a"; # Surface1 (Row selections, borders)
    overlay       = "585b70"; # Surface2 (Inactive window outlines, hints)
    
    # Unified Typography
    textMain      = "cdd6f4"; # Primary crisp text
    textMuted     = "a6adc8"; # Secondary subtexts/labels

    # Brand Accent Family (Unifying window borders, power buttons, and alerts)
    guardsRed     = "e60000"; # True Porsche Guards Red (Primary Focus Accent)
    crimsonDark   = "990000"; # Muted Shadow Red
    chiliNeon     = "ff3333"; # Neon Warning Red

    # Nord Heritage Suite (Retained for your multi-colored Waybar layout blocks)
    nord0         = "2e3440"; # Polar Night Dark
    nord1         = "4c566a"; # Polar Night Medium
    nord3         = "7e8799"; # Polar Night Light Framework
    nord4         = "eceff4"; # Snow Storm White
    nord7         = "8fbcbb"; # Frost Cyan (Bluetooth)
    nord8         = "88c0d0"; # Frost Ice Blue
    nord9         = "81a1c1"; # Frost Steel Blue (Network)
    nord11        = "bf616a"; # Aurora Red (CPU)
    nord12        = "d08770"; # Aurora Orange (Memory)
    nord13        = "ebcb8b"; # Aurora Yellow (Temperature)
    nord14        = "a3be8c"; # Aurora Green (Audio)
    nord15        = "b48ead"; # Aurora Purple (Clock)
  };
in
{
  # 1. Centralized Typography Architecture
  font = {
    family  = "JetBrains Mono Nerd Font";
    size    = "12";
    gtkName = "JetBrains Mono Nerd Font 12";
  };

  # 2. Raw Hex Access (Fallback aligned with top-level block binding name)
  raw = colors;

  # 3. Standard Color Properties (Flat root strings for backwards compatibility)
  bgMain       = colors.bgMain;
  bgCrust      = colors.bgCrust;
  surface      = colors.surface;
  surfaceMuted = colors.surfaceMuted;
  overlay      = colors.overlay;
  textMain     = colors.textMain;
  textMuted    = colors.textMuted;
  guardsRed    = colors.guardsRed;

  # 4. CSS Target Formatting Engine (Prefixes everything with '#')
  css = builtins.mapAttrs (name: value: "#${value}") colors;

  # 5. Hyprland/Hyprlock Specific Engine (Formats into 'rgba(HEXff)')
  hypr = builtins.mapAttrs (name: value: "rgba(${value}ff)") colors;
}