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

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "image/png" = ["org.gnome.Loupe.desktop"];
      "image/jpg" = ["org.gnome.Loupe.desktop"];
      "image/jpeg" = ["org.gnome.Loupe.desktop"];
      "image/webp" = ["org.gnome.Loupe.desktop"];
      "image/gif" = ["org.gnome.Loupe.desktop"];
      "image/svg+xml" = ["org.gnome.Loupe.desktop"];
    };
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
    #motherboard component rgb control
      openrgb-with-all-plugins
  ];
}
