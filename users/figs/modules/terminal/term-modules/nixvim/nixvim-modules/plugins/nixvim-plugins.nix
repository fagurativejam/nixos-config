{ ... }:
{
  programs.nixvim.plugins = {
    #===UI===
      alpha = {
        enable = true;
        #Fancy startup dasboard with custom ascii and quick-action buttons
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
                      keymap = [ "n" "c" "<cmd>e ~/Bullshit/users/figs/modules/nixvim.nix<CR>" { noremap = true; silent = true; } ];
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
      barbecue = {
        enable = true;
        #Winbar: shows current file path and symbols at end of each window
      };
      bufferline = {
        enable = true;
        #Tab-like buffer line at the top
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
      lualine = {
        enable = true;
        #Customizable status line at bottom (similar to zsh agnoster)
        settings = {
          options = {
            theme = "catppuccin";
            globalstatus = true;
            component_separators = { left = "|"; right = "|"; };
            section_separators = { left = ""; right = ""; };
          };
        };
      };
      neo-tree = {
        enable = true;
        #File explorer sidebar
        settings.closeIfLastWindow = true;
      };
      noice = {
        enable = true;
        #Replaces default UI for messages, cmdline, and popup notifications
        settings.presets = {
          bottom_search = false;
          command_palette = true;
          long_message_to_split = true;
          lsp_doc_border = true;
        };
      };
    #===LSP & Completion===
      cmp = {
        enable = true;
        # completion engine (pop-up suggestions)
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
      lsp = {
        enable = true;
        #core language server protocol support
        servers = {
          nil_ls.enable = true;
          pyright.enable = true;
        };
      };
    #===Editing & Navigation===
      auto-save = {
        enable = true;
        #Automatically saves buffers on InsertLeave and TextChanged
        settings = {
          enabled = true;
          trigger_events = {
            InsertLeave = true;
            TextChanged = true;
          };
        };
      };
      comment = {
        enable = true;
        #smart code commenting (gcc, gc in visual mode, etc.)
      };
      indent-blankline = {
        enable = true;
        #show indention guides / scope lines
        settings = {
          scope = { enabled = true; show_start = false; };
          exclude = { filetypes = [ "alpha" "neo-tree" ]; };
        };
      };
      nvim-autopairs = {
        enable = true;
        #Auto-insert matching brackets, quotes, etc.
      };
      nvim-ufo = {
        enable = true;
        #modern permanent buffering
        settings = {
          provider_selector = ''
            function(bufnr, filetype, buftype)
              return 'indent'
            end
          '';
        };
      };
      telescope = {
        enable = true;
        #fuzzy finder for files, grep, oldfiles, etc.
      };
      which-key = {
        enable = true;
        #shows available keybindings when you press <leader>
      };
    #===Syntax, Git, & Extras===
      colorizer = {
        enable = true;
        #holight color codes inline
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
      dressing = {
        enable = true;
        #Improves UI  for input() and select () (better rename, etc.)
      };
      gitsigns = {
        enable = true;
        #git signs in butter and blame
        settings.current_line_blame = true;
      };
      rainbow-delimiters = {
        enable = true;
        #Colorize nested parentheses/ brackets for easier reading
      };
      treesitter = {
        enable = true;
        #better syntax highlighting, indentation, and parsing
        settings = {
          highlight.enable = true;
          indent.enable = true;
          rainbow.enable = true;
        };
      };
      trouble = {
        enable = true;
        #better diagnistics list / quickfix view
      };
      ts-autotag = {
        enable = true;
        #auto-close/rename html/jsx tags (requires tresitter)
      };
    #===Q.O.L.===
      neoscroll = {
        enable = true;
        #smooth scrolling animations
      };
      toggleterm = {
        enable = true;
        #integrated terminal with floating/panel support
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
      web-devicons = {
        enable = true;
        #pretty icons for files, folders, etc (used by many plugins)
      };
  };
}
