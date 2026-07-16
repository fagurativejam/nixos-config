{ pkgs, inputs, ... }:

{
  home = {
    username = "figs";
    homeDirectory = "/home/figs";
    stateVersion = "25.05"; # match your NixOS release
  };

  my.hyprland.enable = true;

  imports = [
    ./modules/common/git.nix
    ./modules/hypr-de/hypr-figs.nix
    ./modules/terminal/terminal.nix
  ];

  programs = {
    home-manager.enable = true;
  };

  news.display = "silent";

  home.pointerCursor = {
    enable=true;
    gtk.enable = true;
    x11.enable = true;
    name = "catppuccin-mocha-dark-cursors";
    package = pkgs.catppuccin-cursors.mochaDark;
    size = 24;
  };

  home.packages = with pkgs; [
    #gaming/ entertainment
      discord
      steam
      spotify
      prismlauncher #minecraft official launcer currently busted
    #audio
      playerctl
    #duh
      firefox
      blender
    # File Management Stack
      thunar                  # The core file manager
      thunar-archive-plugin   # Right-click "Extract Here" / "Compress"
      thunar-volman           # Removable device management extensions
  ];
}
