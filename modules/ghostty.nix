{ lib, ... }:
{
  options.my.desktop.ghostty.settings = lib.mkOption {
    type = lib.types.attrs;
    default = {};
    description = "Ghostty settings.";
  };

  options.my.desktop.ghostty.keybindings = lib.mkOption {
    type = lib.types.listOf lib.types.str;
    default = [];
    description = "Ghostty keybindings.";
  };

  config = {
    programs.ghostty.enable = true;
    programs.ghostty.settings = config.my.desktop.ghostty.settings;
    programs.ghostty.keybindings = config.my.desktop.ghostty.keybindings;
  };
}
