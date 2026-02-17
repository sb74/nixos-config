{ config, pkgs, ... }:

{
  # hyprpaper — Hyprland-native wallpaper manager
  home.packages = with pkgs; [
    hyprpaper
  ];

  # hyprpaper config — set a default wallpaper
  # Stylix will manage wallpaper when configured; this is the fallback
  xdg.configFile."hypr/hyprpaper.conf".text = ''
    # Preload wallpapers
    # preload = /path/to/wallpaper.jpg

    # Set wallpaper for all monitors
    # wallpaper = ,/path/to/wallpaper.jpg

    # Splash (disable — Stylix will handle theming)
    splash = false
    ipc = on
  '';
}
