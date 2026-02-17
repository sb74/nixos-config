{ config, pkgs, ... }:

{
  # Screenshot pipeline: grim + slurp + satty
  home.packages = with pkgs; [
    grim     # Screenshot tool for Wayland
    slurp    # Region selector for Wayland
    satty    # Screenshot annotation tool (replaces swappy)
  ];

  # Keybindings are in desktop/hyprland.nix:
  #   Print         → grim -g "$(slurp)" - | satty --filename -
  #   Shift+Print   → grim -g "$(slurp)" - | wl-copy
  #   Super+Print   → hyprpicker -a
}
