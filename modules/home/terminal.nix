{ lib, config, pkgs, ... }:

{
  options.my.desktop.terminal = {
    enable = lib.mkEnableOption "Enable terminal stack (Zsh + WezTerm)";

    zshAliases = lib.mkOption {
      type = lib.types.attrsOf lib.types.str;
      default = {
        hmrbld  = "nix run .#home-manager -- switch --flake .#figs";
        hm      = "nix run .#home-manager --";
        rebuild = "sudo nixos-rebuild switch --flake .#starkiller";
        update  = "nix flake update";
        garbage = "sudo nix-collect-garbage -d";
      };
      description = "Custom Zsh aliases.";
    };

    ohMyZshTheme = lib.mkOption {
      type = lib.types.str;
      default = "agnoster";
      description = "Oh-My-Zsh theme.";
    };

    ohMyZshPlugins = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ "git" ];
      description = "Oh-My-Zsh plugins.";
    };

    initContent = lib.mkOption {
      type = lib.types.lines;
      default = "";
      description = "Extra initialization content for Zsh.";
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
        theme = config.my.desktop.terminal.ohMyZshTheme;
        plugins = config.my.desktop.terminal.ohMyZshPlugins;
      };

      initExtra = config.my.desktop.terminal.initContent;
    };

    programs.wezterm.enable = true;

    # Extra terminal tools
    programs.fzf.enable = true;
    programs.bat.enable = true;
    programs.nnn.enable = true;

    home.sessionVariables = {
      TERMINAL = "wezterm";
      PAGER = "bat";
    };
  };
}
