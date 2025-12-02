{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;

    plugins = with pkgs.vimPlugins; [
      telescope-nvim
      nvim-web-devicons
      lualine-nvim

      (nvim-treesitter.withPlugins (p: [ p.python p.nix ]))

      nvim-lspconfig
      nvim-cmp
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      cmp_luasnip
      luasnip
      catppuccin-nvim

      # Add these two so your Lua config works:
      conform-nvim
      nvim-lint
    ];

    extraLuaConfig = ''
      require("catppuccin").setup { flavour = "mocha" }
      vim.cmd.colorscheme "catppuccin"

      require("nvim-treesitter.configs").setup {
        highlight = { enable = true },
      }

      local lspconfig = require("lspconfig")
      lspconfig.pyright.setup {}
      lspconfig.nil_ls.setup {}

      require("conform").setup {
        formatters_by_ft = {
          python = { "black" },
          nix    = { "nixfmt" },
        },
        format_on_save = { timeout_ms = 500, lsp_fallback = true },
      }

      local lint = require("lint")
      lint.linters_by_ft = {
        python = { "flake8" },
        nix    = { "statix" },
      }
      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        callback = function() lint.try_lint() end,
      })
    '';
  };
}