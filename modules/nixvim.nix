{ inputs, pkgs, ... }:

{
  imports = [ inputs.nixvim.homeManagerModules.nixvim ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    extraLuaConfig = ''
      vim.opt.number = true
      vim.opt.relativenumber = true
      vim.opt.termguicolors = true
    '';

    plugins = {
      lualine.enable = true;
      treesitter.enable = true;
      telescope.enable = true;
      lsp.enable = true;
    };

    colorschemes.catppuccin = {
      enable = true;
      flavour = "mocha";
    };
  };
}