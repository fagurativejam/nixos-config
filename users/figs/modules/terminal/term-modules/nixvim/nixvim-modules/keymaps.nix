{ ... }:

{
  programs.nixvim = {
    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };

    keymaps = [
      # ==================== Navigation & Files ====================
        { mode = "n"; key = "<leader>ff"; action = "<cmd>Telescope find_files<cr>";  options.desc = "Find files"; }
        { mode = "n"; key = "<leader>fg"; action = "<cmd>Telescope live_grep<cr>";   options.desc = "Live grep (search in project)"; }
        { mode = "n"; key = "<leader>fr"; action = "<cmd>Telescope oldfiles<cr>";    options.desc = "Recent files"; }
        { mode = "n"; key = "<leader>fb"; action = "<cmd>Telescope buffers<cr>";     options.desc = "Switch buffers"; }
        { mode = "n"; key = "<leader>fh"; action = "<cmd>Telescope help_tags<cr>";   options.desc = "Help tags"; }
        { mode = "n"; key = "<leader>e";  action = "<cmd>Neotree toggle<cr>";        options = { silent = true; desc = "Toggle file explorer"; }; }
      # ==================== LSP ====================
        { mode = "n"; key = "<leader>ca"; action = "<cmd>lua vim.lsp.buf.code_action()<cr>"; options.desc = "Code actions"; }
        { mode = "n"; key = "gd";         action = "<cmd>lua vim.lsp.buf.definition()<cr>";  options.desc = "Go to definition"; }
        { mode = "n"; key = "gD";         action = "<cmd>lua vim.lsp.buf.declaration()<cr>"; options.desc = "Go to declaration"; }
        { mode = "n"; key = "gi";         action = "<cmd>lua vim.lsp.buf.implementation()<cr>"; options.desc = "Go to implementation"; }
        { mode = "n"; key = "gr";         action = "<cmd>lua vim.lsp.buf.references()<cr>"; options.desc = "Find references"; }
        { mode = "n"; key = "K";          action = "<cmd>lua vim.lsp.buf.hover()<cr>";       options.desc = "Hover documentation"; }
        { mode = "n"; key = "<leader>rn"; action = "<cmd>lua vim.lsp.buf.rename()<cr>";      options.desc = "Rename symbol"; }
      # ==================== Buffer & Window Management ====================
        { mode = "n"; key = "<Tab>";       action = "<cmd>BufferLineCycleNext<CR>";   options = { silent = true; desc = "Next buffer"; }; }
        { mode = "n"; key = "<S-Tab>";     action = "<cmd>BufferLineCyclePrev<CR>";   options = { silent = true; desc = "Previous buffer"; }; }
      # Window navigation (Ctrl + hjkl)
        { mode = "n"; key = "<C-h>"; action = "<C-w>h"; options.desc = "Go to left window"; }
        { mode = "n"; key = "<C-j>"; action = "<C-w>j"; options.desc = "Go to lower window"; }
        { mode = "n"; key = "<C-k>"; action = "<C-w>k"; options.desc = "Go to upper window"; }
        { mode = "n"; key = "<C-l>"; action = "<C-w>l"; options.desc = "Go to right window"; }
      # ==================== Folding ====================
        { mode = "n"; key = "zR"; action = "<cmd>lua require('ufo').openAllFolds()<CR>";  options.desc = "Open all folds"; }
        { mode = "n"; key = "zM"; action = "<cmd>lua require('ufo').closeAllFolds()<CR>"; options.desc = "Close all folds"; }
      # ==================== Utility / Quality of Life ====================
        { mode = "n"; key = "<leader>ya"; action = "<cmd>%y+<CR>";          options.desc = "Yank entire file to clipboard"; }
        { mode = "n"; key = "<Esc>";      action = "<cmd>nohlsearch<CR>";   options.desc = "Clear search highlights"; }
      # Format (if you enable conform.nvim or lsp formatting later)
        # { mode = "n"; key = "<leader>f"; action = "<cmd>lua vim.lsp.buf.format()<cr>"; options.desc = "Format buffer"; }
      # Terminal (ToggleTerm)
        { mode = "n"; key = "<C-\\>"; action = "<cmd>ToggleTerm<CR>"; options = { silent = true; desc = "Toggle terminal"; }; }
        { mode = "t"; key = "<C-\\>"; action = "<cmd>ToggleTerm<CR>"; options = { silent = true; desc = "Toggle terminal"; }; }
    ];
  };
}
