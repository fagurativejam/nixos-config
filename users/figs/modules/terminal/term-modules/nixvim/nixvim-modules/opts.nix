{ ... }:

{
  programs.nixvim.opts = {
    # ==================== Appearance ====================
    number = true;              # Show line numbers
    relativenumber = true;      # Relative line numbers
    cursorline = true;          # Highlight current line
    signcolumn = "yes";         # Always show sign column (for git, diagnostics, etc.)
    foldcolumn = "1";           # Show folding column next to line numbers
    termguicolors = true;       # Enable true color support

    # ==================== Indentation ====================
    tabstop = 2;                # Number of spaces a tab counts for
    shiftwidth = 2;             # Size of indent
    expandtab = true;           # Use spaces instead of tabs

    # ==================== Folding ====================
    foldenable = true;          # Enable folding
    foldlevel = 99;             # Start with most folds open
    foldlevelstart = 99;        # Same as above
    foldopen = "block,hor,mark,percent,quickfix,search,tag,undo"; # Which actions open folds

    # ==================== Search ====================
    ignorecase = true;          # Ignore case in search
    smartcase = true;           # Override ignorecase when search has uppercase
    hlsearch = true;            # Highlight search matches
    wrapscan = true;            # Searches wrap around end of file

    # ==================== Editor Behavior ====================
    clipboard = "unnamedplus";  # Sync Neovim clipboard with system clipboard
    selectmode = "mouse,key";   # Make Shift+arrows work for selection

    splitright = true;          # Vertical splits open to the right
    splitbelow = true;          # Horizontal splits open below

    scrolloff = 8;              # Keep 8 lines above/below cursor
    wrap = false;               # Don't wrap long lines

    # ==================== Files & Backup ====================
    undofile = true;            # Persistent undo history
    swapfile = false;           # Disable swap files

    # View options (what to save when using mkview)
    viewoptions = [ "folds" "cursor" ];
  };
}
