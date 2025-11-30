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
      };
      description = "Custom Zsh aliases.";
    };
  };

  config = lib.mkIf config.my.desktop.terminal.enable {
    programs.zsh = {
      enable = true;
      autosuggestion.enable = true;   # fixed
      syntaxHighlighting.enable = true;
      enableCompletion = true;
      shellAliases = config.my.desktop.terminal.zshAliases;

      oh-my-zsh = {
        enable = true;
        theme = "agnoster";
        plugins = [ 
          "git"
        ];
      };

      initContent = ''
        eval "$(direnv hook zsh)"
      '';
    };

    programs.wezterm.enable = true;

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

    programs.fzf.enable = true;
    programs.bat.enable = true;
    programs.eza.enable = true;
    programs.ripgrep.enable = true;
    programs.zoxide.enable = true;
    programs.direnv.enable = true;

    home.sessionVariables = {
      TERMINAL = config.my.desktop.terminal.defaultTerminal;
      PAGER = "bat";
    };
  };
}
