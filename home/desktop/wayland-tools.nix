{ config, pkgs, ... }:

{
  # Wayland desktop utilities
  home.packages = with pkgs; [
    hyprpicker      # Color picker
    brightnessctl   # Backlight control
    wev             # Wayland event viewer (debug keybinds)
    wtype           # Wayland keystroke simulator (for clipboard bindings)
  ];

  # SwayOSD — volume/brightness on-screen display
  services.swayosd = {
    enable = true;
  };
}
