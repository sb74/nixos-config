{ config, pkgs, ... }:

{
  # Clipboard management for Wayland
  home.packages = with pkgs; [
    wl-clipboard       # wl-copy / wl-paste — core clipboard tools
    wl-clip-persist    # Keep clipboard after source app closes
    cliphist           # Clipboard history manager
  ];

  # Autostart and keybindings are in desktop/hyprland.nix:
  #   exec-once: wl-clip-persist --clipboard regular
  #   exec-once: wl-paste --type text --watch cliphist store
  #   exec-once: wl-paste --type image --watch cliphist store
  #   Super+Ctrl+V: cliphist list | walker --dmenu | cliphist decode | wl-copy
}
