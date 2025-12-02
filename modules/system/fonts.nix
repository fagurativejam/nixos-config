{ config, pkgs, ... }:

{
  fonts = {
    fontDir.enable = true;
    fontconfig.enable = true;

    # Install Nerd Fonts (choose curated subset or all)
    packages = with pkgs; [
      nerd-fonts.fira-code
      nerd-fonts.jetbrains-mono
      nerd-fonts.hack
      nerd-fonts.iosevka
      nerd-fonts.sauce-code-pro
      nerd-fonts.dejavu-sans-mono
      nerd-fonts.ubuntu-mono
      nerd-fonts.droid-sans-mono
      nerd-fonts.symbols-only
    ];

    # Alternative: install all Nerd Fonts in one go
    # packages = [ pkgs.nerd-fonts ];
  };
}
