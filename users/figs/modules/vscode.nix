{pkgs, ...}: 
{
  # programs.vscode = {
  #   enable = true;
  #   package = pkgs.vscode;

  #   profiles.default = {
  #     extensions = with pkgs.vscode-extensions; [
  #       #nix extensions
  #         bbenoist.nix
  #         jnoortheen.nix-ide
  #         mkhl.direnv
  #         arrterian.nix-env-selector
  #       #python extensions
  #         ms-python.python
  #         ms-toolsai.jupyter
  #       #rust extensions
  #         rust-lang.rust-analyzer
  #         tamasfe.even-better-toml
  #     ];

  #     userSettings = {
  #       #Nix
  #         "nix.enableLangeuageServer" = true;
  #         "nix.serverPath" = "nil";
  #         "nix.formatterPath" = "alejandra";

  #       #Python
  #         "python.defaultInterpreterPath" = "${pkgs.python3}/bin/python";
  #         "python.linting.enabled" = true;
  #         "python.formatting.provider" = "black";

  #       #Rust
  #         "rust-analyzer.server.path" = "${pkgs.rust-analyzer}/bin/rust-analyzer";

  #       #General
  #         "formatOnSave" = false;
  #         "editor.formatOnSave" = false;
  #         "editor.tabSize" = 2;
  #         "files.autoSave" = "afterDelay";
  #         "terminal.integrated.defaultProfile.linux" = "zsh";

  #       #Direnv
  #         "direnv.path" = "${pkgs.direnv}/bin/direnv";
  #     };
  #   };
  # };

  # home.packages = with pkgs; [
  #   nil
  #   alejandra
  #   direnv
  #   python3
  #   black
  #   python3Packages.pip
  #   rust-analyzer
  # ];
}
