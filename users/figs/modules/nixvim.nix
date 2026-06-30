{ pkgs, inputs, ... }:

{
  imports = [
    inputs.nixvim.homeModules.nixvim
  ];

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

    opts = {
      number = true;
      relativenumber = true;
      tabstop = 2;
      shiftwidth = 2;
      expandtab = true;
      cursorline = true;
      signcolumn = "yes";
      termguicolors = true;
      foldcolumn = "1";       # Shows the folding bar on the left next to line numbers
      foldlevel = 99;         # Keeps folds open by default unless manually collapsed
      foldlevelstart = 99;    # Ensures files start with open folds
      foldenable = true;      # Globally enables code folding
      clipboard = "unnamedplus"; # Syncs Neovim yank register with system clipboard
      selectmode = "mouse,key";  # Ensures Shift+Arrows triggers selection mode
      splitright = true;
      splitbelow = true;
      ignorecase = true;
      smartcase = true;
      hlsearch = true;
      scrolloff = 8;
      wrap = false;
      undofile = true;
      swapfile = false;
    };

    plugins = {
      lualine = {
        enable = true;
        settings = {
          options = {
            theme = "catppuccin";
            globalstatus = true;
            component_separators = { left = "|"; right = "|"; };
            section_separators = { left = ""; right = ""; };
          };
        };
      };
      
      auto-save = {
        enable = true;
        settings = {
          enabled = true;
          trigger_events = {
            InsertLeave = true;
            TextChanged = true;
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

      rainbow-delimiters.enable = true;

      nvim-ufo = {
        enable = true;
        settings = {
          provider_selector = ''
            function(bufnr, filetype, buftype)
              return 'indent'
            end
          '';
        };
      };


      indent-blankline = {
        enable = true;
        settings = {
          scope = { enabled = true; show_start = false; };
          exclude = { filetypes = [ "alpha" "neo-tree" ]; };
        };
      };

      telescope.enable = true;

      treesitter = {
        enable = true;
        settings = {
          highlight.enable = true;
          indent.enable = true;
          rainbow.enable = true;
        };
      };

      neoscroll.enable = true;
      ts-autotag.enable = true;
      colorizer = {
        enable = true;
        settings = {
          filetypes = [ "*" ]; # Target all active files
          user_default_options = {
            RGB = true;        # Highlights standard RGB text
            RRGGBB = true;     # Highlights standard Hex codes
            css = true;        # Enables parsing of CSS color rules
            css_fn = true;     # FORCES parsing of functional rgb() and rgba() strings
          };
        };
      };
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
              hl = "Type";
            };
          }
          { type = "padding"; val = 2; }
          # Buttons
          {
            type = "group";
            val = [
              #new file
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
              #find file
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
              #find text
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
              #recent files
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
              #link to this file
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
              #quit
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
          nil_ls = {
            enable = false;
          };
          pyright.enable = false;
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
      { mode = "n"; key = "<leader>ca"; action = "<cmd>lua vim.lsp.buf.code_action<cr>"; }
      { mode = "n"; key = "gd"; action = "<cmd>lua vim.lsp.buf.definition()<cr>"; }
      { mode = "n"; key = "K"; action = "<cmd>lua vim.lsp.buf.hover()<cr>"; }
      { mode = "n"; key = "<leader>e"; action = "<cmd>Neotree toggle<cr>"; options ={ silent = true; }; }
      { mode = "n"; key = "<leader>x"; action = "<cmd>Bdelete<cr>"; options ={ silent = true; }; }
      { mode = "n"; key = "<Tab>"; action = "<cmd>BufferLineCycleNext<CR>"; options ={ silent = true; }; }
      { mode = "n"; key = "<S-Tab>"; action = "<cmd>BufferLineCyclePrev<CR>"; options ={ silent = true; }; }
      { mode = "n"; key = "zR"; action = "<cmd>lua require('ufo').openAllFolds()<CR>"; options.desc = "Open all folds"; }
      { mode = "n"; key = "zM"; action = "<cmd>lua require('ufo').closeAllFolds()<CR>"; options.desc = "Close all folds"; }
      { mode = "n"; key = "<leader>ya"; action = "<cmd>%y+<CR>"; options.desc = "Yank entire file to system clipboard"; }
      { mode = "n"; key = "<Esc>"; action = "<cmd>nohlsearch<CR>"; options.desc = "Clear search highlights"; }
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
