{ pkgs, inputs, myTheme, ... }:

let 
  colors=myTheme.colors;
  hex = myTheme.toHashHex;
in
{
  imports = [
    inputs.nixvim.homeModules.nixvim
    ./nixvim-modules/autocmds.nix
    ./nixvim-modules/keymaps.nix
    ./nixvim-modules/opts.nix
    ./nixvim-modules/plugins/nixvim-plugins.nix
  ];

  xdg.desktopEntries.nixvim = {
    name = "Nixvim";
    genericName = "Text Editor";
    exec = "wezterm start -- nvim %F";
    terminal = false;
    categories = ["Utility" "TextEditor" "Development"];
    mimeType = ["text/plain" "text/markdown" "application/x-zerosize"];
    icon = "nvim";
  };

  programs.nixvim = {
    enable = true;
    nixpkgs.source = pkgs.path;

    colorschemes.catppuccin = {
      enable = true;
      settings = {
        flavor = "mocha"; # latte, frappe, macchiato, mocha
        transparent_background = true;
      };
     };
    extraPackages = with pkgs; [
      ripgrep #for telescope live_grep
      fd #faster find_files (telescope)
      tree-sitter #tree-sitter CLI
    ];
    extraPlugins = with pkgs.vimPlugins; [
      bufdelete-nvim
    ];
  };

  home.packages = with pkgs; [
    #LSP
    nil
    pyright
    #formatters/linters
    alejandra
    black
    #miscutilities
    imagemagick
    file
  ];
}

