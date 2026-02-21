{ config, pkgs, ... }:

{
  fonts = {
    enableDefaultPackages = true;

    packages = with pkgs; [
      # Nerd Fonts — primary terminal/editor fonts
      nerd-fonts.caskaydia-mono
      nerd-fonts.jetbrains-mono

      # Noto — comprehensive Unicode coverage
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji

      # Font Awesome — icons for Waybar
      font-awesome
    ];

    fontconfig = {
      defaultFonts = {
        monospace = [ "CaskaydiaMono Nerd Font" "Noto Sans Mono" ];
        sansSerif = [ "Noto Sans" ];
        serif     = [ "Noto Serif" ];
        emoji     = [ "Noto Color Emoji" ];
      };
    };
  };
}
