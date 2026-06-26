# /users/figs/modules/nixvim.nix
{ pkgs, inputs, ... }:

let
  palette = import ./palette.nix;
in
{
  imports = [
    inputs.nixvim.homeModules.nixvim
  ];

  programs.nixvim = {
    enable = true;

    # Explicitly managing editor-wide syntax layout using your palette token strings
    highlight = {
      # --- Editor Core Structural Blocks ---
      Normal = { fg = palette.css.textMain; bg = "none"; };       # Force pure transparent backdrop
      NormalFloat = { fg = palette.css.textMain; bg = "none"; };  # Floating panels inherit transparency
      FloatBorder = { fg = palette.css.overlay; bg = "none"; };   # Muted borders for floating containers
      
      # --- UI Accents & Feedback Modules ---
      Visual = { bg = palette.css.guardsRed; fg = palette.css.bgCrust; bold = true; }; # High-contrast selection
      CursorLine = { bg = palette.css.surface; };                                    # Active row background track
      CursorLineNr = { fg = palette.css.guardsRed; bold = true; };                     # Active line number accent
      LineNr = { fg = palette.css.overlay; };                                         # Inactive line numbers
      SignColumn = { bg = "none"; };                                                  # Left gutter background
      
      # --- Code Syntax Framework ---
      Comment = { fg = palette.css.overlay; italic = true; };
      Constant = { fg = palette.css.nord12; };    # Map Orange to static constants
      String = { fg = palette.css.nord14; };      # Map Green to text strings
      Identifier = { fg = palette.css.textMain; }; # Main variables remain crisp text color
      Function = { fg = palette.css.nord8; };     # Map Light Blue to function calls
      Statement = { fg = palette.css.nord15; };    # Map Purple to control words (if/then/return)
      PreProc = { fg = palette.css.nord9; };       # Map Steel Blue to pre-processor directives
      Type = { fg = palette.css.nord7; };          # Map Cyan to types/structs
      Special = { fg = palette.css.textMuted; };   # Muted highlights for edge case symbols
      
      # --- Tooling Overrides (Telescope / Search) ---
      Search = { bg = palette.css.surfaceMuted; fg = palette.css.guardsRed; bold = true; };
      TelescopeMatching = { fg = palette.css.guardsRed; bold = true; };
      TelescopeSelection = { bg = palette.css.surface; fg = palette.css.textMain; };
      
      # --- Alpha Dashboard Highlight Slots ---
      AlphaHeader = { fg = palette.css.guardsRed; bold = true; };
      AlphaShortcut = { fg = palette.css.guardsRed; italic = true; };
    };

    opts = {
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
      # Customizing Lualine without importing a base theme bundle
      lualine = {
        enable = true;
        settings = {
          options = {
            # Let lualine generate structural coloring cleanly
            globalstatus = true;
            component_separators = { left = "|"; right = "|"; };
            section_separators = { left = ""; right = ""; };
          };
        };
      };
      
      bufferline = {
        enable = true;
        settings = {
          options = {
            separator_style = "thin";
            transparent_background = true;
            diagnostics = "nvim-lsp";
            show_buffer_close_icons = false;
            show_close_icon = false;
            always_show_bufferline = true;
            offsets = [
              {
                filetype = "neotree";
                text = "File Explorer";
                text_align = "center";
                separator = true;
              }
            ];
          };
        };
      };

      neo-tree = {
        enable = true;
        settings.closeIfLastWindow = true;
      };
      
      telescope.enable = true;
      treesitter.enable = true;
      web-devicons.enable = true;
      nvim-autopairs.enable = true;
      comment.enable = true;
      which-key.enable = true;
      trouble.enable = true;
      
      alpha = {
        enable = true;
        settings.layout = [
          { type = "padding"; val = 2; }
          # Header
          {
            type = "text";
            val = [
              " ::::    ::: ::::::::::: :::    ::: :::     ::: ::::::::::: ::::    ::::  "
              " :+:+:   :+:     :+:     :+:    :+: :+:     :+:     :+:     +:+:+: :+:+:+ "
              " :+:+:+  +:+     +:+      +:+  +:+  +:+     +:+     +:+     +:+ +:+:+ +:+ "
              " +#+ +:+ +#+     +#+       +#++:+   +#+     +:+     +#+     +#+  +:+  +#+ "
              " +#+  +#+#+#     +#+      +#+  +#+   +#+   +#+      +#+     +#+       +#+ "
              " #+#   #+#+#     #+#     #+#    #+#   #+#+#+#       #+#     #+#       #+# "
              " ###    #### ########### ###    ###     ###     ########### ###       ### "
            ];
            opts = {
              position = "center";
              hl = "AlphaHeader";
            };
          }
          { type = "padding"; val = 2; }
          # Buttons
          {
            type = "group";
            val = [
              {
                type = "button";
                val = "  New File";
                opts = {
                  keymap = [ "n" "e" "<cmd>ene <CR>" { noremap = true; silent = true; } ];
                  shortcut = "e";
                  position = "center";
                  hl = "Special";
                  hl_shortcut = "AlphaShortcut";
                  width = 35;
                  align_shortcut = "right";
                };
              }
              { type = "padding"; val = 1; }
              {
                type = "button";
                val = " 󰮗 Find File";
                opts = {
                  keymap = [ "n" "f" "<cmd>Telescope find_files<CR>" { noremap = true; silent = true; } ];
                  shortcut = "f";
                  position = "center";
                  hl = "Special";
                  hl_shortcut = "AlphaShortcut";
                  width = 35;
                  align_shortcut = "right";
                };
              }
              { type = "padding"; val = 1; }
              {
                type = "button";
                val = " 󱘣 Find Text";
                opts = {
                  keymap = [ "n" "g" "<cmd>Telescope live_grep<CR>" { noremap = true; silent = true; } ];
                  shortcut = "g";
                  position = "center";
                  hl = "Special";
                  hl_shortcut = "AlphaShortcut";
                  width = 35;
                  align_shortcut = "right";
                };
              }
              { type = "padding"; val = 1; }
              {
                type = "button";
                val = " 󱋢 Recent Files";
                opts = {
                  keymap = [ "n" "r" "<cmd>Telescope oldfiles<CR>" { noremap = true; silent = true; } ];
                  shortcut = "r";
                  position = "center";
                  hl = "Special";
                  hl_shortcut = "AlphaShortcut";
                  width = 35;
                  align_shortcut = "right";
                };
              }
              { type = "padding"; val = 1; }
              {
                type = "button";
                val = "  Open Configuration";
                opts = {
                  keymap = [ "n" "c" "<cmd>e ~/home/figs/Bullshit/users/figs/modules/nixvim.nix<CR>" { noremap = true; silent = true; } ];
                  shortcut = "c";
                  position = "center";
                  hl = "Special";
                  hl_shortcut = "AlphaShortcut";
                  width = 35;
                  align_shortcut = "right";
                };
              }
              { type = "padding"; val = 1; }
              {
                type = "button";
                val = " 󰈆 Quit NixVIM";
                opts = {
                  keymap = [ "n" "q" "<cmd>qa <CR>" { noremap = true; silent = true; } ];
                  shortcut = "q";
                  position = "center";
                  hl = "Special";
                  hl_shortcut = "AlphaShortcut";
                  width = 35;
                  align_shortcut = "right";
                };
              }
              { type = "padding"; val = 2; }
              # Footer
              {
                type = "text";
                val = [
                  "󰜗 Welcome to my sick and twisted NVIM 󰜗"
                ];
                opts = {
                  position = "center";
                  hl = "Comment";
                };
              }
            ];
          }
        ];
      };

      indent-blankline = {
        enable = true;
        settings = {
          scope = {
            enabled = true;
            show_start = false;
          };
        };
      };
      
      todo-comments.enable = true;
      noice = {
        enable = true;
        settings.presets = {
          bottom_search = false;
          command_palette = true;
          long_message_to_split = true;
          lsp_doc_border = true;
        };
      };
      
      dressing.enable = true;
      gitsigns = {
        enable = true;
        settings.current_line_blame = true;
      };
      barbecue.enable = true;
      rainbow-delimiters.enable = true;
      
      toggleterm = {
        enable = true;
        settings = {
          open_mapping = "[[<c-\\>]]";
          direction = "float";
          highlights = {
            NormalFloat = { link = "NormalFloat"; };
            FloatBorder = { link = "FloatBorder"; };
          };
          float_opts = {
            border = "rounded";
            winblend = 0;
          };
        };
      };
      
      lsp = {
        enable = true;
        postConfig = ''
          vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border= "rounded"})
          vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signatureHelp, { border= "rounded"})
        '';
        servers = {
          nil_ls.enable = true;
          pyright.enable = true;
          rust_analyzer = { 
            enable = true;
            installCargo = true;
            installRustc = true; 
          };
        };
      };
      
      cmp = {
        enable = true;
        settings = {
          window = {
            completion.__raw = "cmp.config.window.bordered()";
            documentation.__raw = "cmp.config.window.bordered()";
          };
          sources = [
            { name = "nvim_lsp"; }
            { name = "path"; }
            { name = "buffer"; }
          ];
          mapping = {
            "<CR>" = "cmp.mapping.confirm({ select = true })";
            "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(),{'i', 's'})";
            "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(),{'i', 's'})";
          };
        };
      };
    };

    globals.mapleader = " ";
    globals.maplocalleader = " ";

    keymaps = [
      { mode = "n"; key = "<leader>ff"; action = "<cmd>Telescope find_files<cr>"; }
      { mode = "n"; key = "<leader>fg"; action = "<cmd>Telescope live_grep<cr>";}
      { mode = "n"; key = "<leader>ca"; action = "<cmd>lua vim.lsb.buf.code_action<cr>"; }
      { mode = "n"; key = "gd"; action = "<cmd>lua vim.lsp.buf.definition()<cr>"; }
      { mode = "n"; key = "K"; action = "<cmd>lua vim.lsp.buf.hover()<cr>"; }
      { mode = "n"; key = "<leader>e"; action = "<cmd>Neotree toggle<cr>"; options ={ silent = true; }; }
      { mode = "n"; key = "<leader>x"; action = "<cmd>Bdelete<cr>"; options ={ silent = true; }; }
      { mode = "n"; key = "<Tab>"; action = "<cmd>BufferLineCycleNext<CR>"; options ={ silent = true; }; }
      { mode = "n"; key = "<S-Tab>"; action = "<cmd>BufferLineCyclePrev<CR>"; options ={ silent = true; }; }
    ];
    
    extraPlugins = with pkgs.vimPlugins; [
      bufdelete-nvim
    ];
  };

  home.packages = with pkgs; [
    tree-sitter
    fd
    nil
    pyright
    rust-analyzer
    alejandra
    black
    rustfmt
  ];
}