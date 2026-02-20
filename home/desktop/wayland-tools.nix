{ config, pkgs, ... }:

{
  # Wayland desktop utilities
  home.packages = with pkgs; [
    hyprpicker      # Color picker
    brightnessctl   # Backlight control
    playerctl       # Media key control (play/pause/next/prev)
    pwvucontrol     # PipeWire volume control GUI
    wev             # Wayland event viewer (debug keybinds)
    wtype           # Wayland keystroke simulator (for clipboard bindings)
    networkmanagerapplet  # nm-connection-editor for waybar wifi click
  ];

  # SwayOSD — volume/brightness on-screen display
  services.swayosd = {
    enable = true;
  };
}
