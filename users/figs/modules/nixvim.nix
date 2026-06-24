{ pkgs, ... }:
{
  programs.nixvim = {
    enable = true;
    
    colorscheme = "catppuccin";

    options = {
      number = true;
      relativenumber = true;
      tabstop = 2;
      shiftwidth = 2;
      expandtab = true;
      cursorline = true;
      signcolumn = "yes";
      termguicolors = true;
    };

    plugins = {

      lualine = {
        enable = true;
        theme = "catppuccin";
      };

      bufferline.enable = true;

      nvim-tree = {
        enable = true;
        openOnTab = true;
      };

      telescope.enable = true;

      treesitter.enable = true;

      web-devicons.enable = true;

      nvim-autopairs.enable = true;

      comment.enable = true;

      which-key.enable = true;

      trouble.enable = true;

      alpha.enable = true;

      indent-blankline.enable = true;

      todo-comments.enable = true;

      lsp = {
        enable = true;
        servers = {
          nil_ls.enable = true;
          pyright.enable = true;
          rust-analyzer.enable = true;
        };
      };

      cmp.enable = true;

      conform-nvim = {
        enable = true;
        formattersByFt = {
          nix = [ "alejandra" ];
          python = [ "black" ];
          rust = [ "rustfmt" ];
        };
      };

    };

    keymaps = [
      { mode = "n"; key = "<leader>e"; action = "<cmd>NvimTreeToggle<cr>"; desc = "File explorer";}
      { mode = "n"; key = "<leader>ff"; action = "<cmd>Telescope find_files<cr>"; desc = "Find files";}
      { mode = "n"; key = "<leader>fg"; action = "<cmd>Telescope live_grep<cr>"; desc = "Live grep";}
      { mode = "n"; key = "<leader>ca"; action = "<cmd>lua vim.lsb.buf.code_action<cr>"; desc = "Code actions";}
      { mode = "n"; key = "K"; action = "<cmd>lua vim.lsp.buf.hover()<cr>"; desc = "Hover docs";}
    ];

  };

  home.packages = with pkgs; [
    catppuccin-nvim
    nil
    pyright
    rust-analyzer
    alejandra
    black
    rustfmt
  ];

}