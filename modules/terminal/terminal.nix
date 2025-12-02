{ lib, config, pkgs, ... }:

{
  options.my.desktop.terminal = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable terminal stack (Zsh WezTerm).";
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
      autosuggestion.enable = true;
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
      '';
    };

    programs.wezterm.enable = true;
    programs.fzf.enable = true;
    programs.bat.enable = true;
    programs.nnn.enable = true;

    home.sessionVariables = {
      TERMINAL = config.my.desktop.terminal.defaultTerminal;
      PAGER = "bat";
    };
  };
}
