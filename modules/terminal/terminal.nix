{ lib, config, pkgs, ... }:

{
  options.my.desktop.terminal = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable terminal stack (Zsh, WezTerm, tmux, etc.).";
    };

    defaultTerminal = lib.mkOption {
      type = lib.types.str;
      default = "wezterm";
      description = "Default terminal emulator to launch.";
    };

    zshAliases = lib.mkOption {
      type = lib.types.attrsOf lib.types.str;
      default = {
        hmrbld = "nix run .#home-manager -- switch --flake .#figs";
        hm = "nix run .#home-manager --";
        rebuild = "sudo nixos-rebuild switch --flake .#starkiller";
        update = "nix flake update";
        garbage = "sudo nix-collect-garbage -d";
        ll = "ls -alF";
        gs = "git status";
        v = "nvim";
        cat = "bat";
        ls = "exa --icons";
        cd = "z";
      };
      description = "Custom Zsh aliases.";
    };
  };

  config = lib.mkIf config.my.desktop.terminal.enable {
    # ┌───────────────────────────────┐
    # │ 🐚 Zsh Configuration          │
    # └───────────────────────────────┘
    programs.zsh = {
      enable = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
      enableCompletion = true;
      shellAliases = config.my.desktop.terminal.zshAliases;

      oh-my-zsh = {
        enable = true;
        theme = "agnoster"; # or "powerlevel10k"
        plugins = [
          "git"
          "zsh-autosuggestions"
          "zsh-syntax-highlighting"
        ];
      };

      initExtra = ''
        eval "$(starship init zsh)"
        eval "$(direnv hook zsh)"
      '';
    };

    # ┌───────────────────────────────┐
    # │ 🖥️ WezTerm Configuration      │
    # └───────────────────────────────┘
    programs.wezterm = {
      enable = true;
      extraConfig = ''
        local wezterm = require 'wezterm'
        return {
          font = wezterm.font("JetBrains Mono"),
          font_size = 12.0,
          color_scheme = "Gruvbox Dark",
          enable_tab_bar = true,
          hide_tab_bar_if_only_one_tab = true,
          window_background_opacity = 0.95,
          keys = {
            {key="t", mods="CTRL|SHIFT", action=wezterm.action{SpawnTab="CurrentPaneDomain"}},
            {key="w", mods="CTRL|SHIFT", action=wezterm.action{CloseCurrentTab={confirm=true}}},
          },
        }
      '';
    };

    # ┌───────────────────────────────┐
    # │ 🔀 Tmux Configuration         │
    # └───────────────────────────────┘
    programs.tmux = {
      enable = true;
      clock24 = true;
      terminal = "screen-256color";
      extraConfig = ''
        set -g mouse on
        set -g history-limit 10000
        setw -g mode-keys vi
      '';
    };

    # ┌───────────────────────────────┐
    # │ 🌟 Starship Prompt            │
    # └───────────────────────────────┘
    programs.starship = {
      enable = true;
      settings = {
        add_newline = false;
        character = {
          success_symbol = "[➜](bold green)";
          error_symbol = "[✗](bold red)";
        };
      };
    };

    # ┌───────────────────────────────┐
    # │ 📦 Extra Terminal Tools       │
    # └───────────────────────────────┘
    programs.fzf.enable = true;
    programs.bat.enable = true;
    programs.exa.enable = true;
    programs.ripgrep.enable = true;
    programs.zoxide.enable = true;
    programs.direnv.enable = true;

    # ┌───────────────────────────────┐
    # │ 🌍 Environment Variables      │
    # └───────────────────────────────┘
    home.sessionVariables = {
      EDITOR = "vscode";
      TERMINAL = config.my.desktop.terminal.defaultTerminal;
      PAGER = "bat";
    };
  };
}
