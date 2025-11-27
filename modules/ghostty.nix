{ lib, ... }:
{
  programs.ghostty = {
    enable = true;
    settings = {
      font = "JetBrainsMono Nerd Font";
      font-size = 12;
      theme = "Catppuccin-Mocha";
      tabs = true;
      tab-bar = "auto";
      keybindings = [
        "SUPER+H: focus-left"
        "SUPER+L: focus-right"
        "SUPER+K: focus-up"
        "SUPER+J: focus-down"
        "SUPER|SHIFT+H: move-left"
        "SUPER|SHIFT+L: move-right"
        "SUPER|SHIFT+K: move-up"
        "SUPER|SHIFT+J: move-down"
        "SUPER|ALT+H: resize-left 5"
        "SUPER|ALT+L: resize-right 5"
        "SUPER|ALT+K: resize-up 2"
        "SUPER|ALT+J: resize-down 2"
        "SUPER+T: new-tab"
        "SUPER+W: close-tab"
        "SUPER+TAB: next-tab"
        "SUPER|SHIFT+TAB: prev-tab"
      ];
    };
  };
}