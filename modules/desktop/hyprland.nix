{ config, pkgs, inputs, ... }:

{
  # Hyprland compositor — system-level
  programs.hyprland = {
    enable = true;
    withUWSM = true;   # Recommended systemd session management
    xwayland.enable = true;
  };

  # XDG Desktop Portal — file pickers, screen sharing
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-hyprland
    ];
  };

  # Polkit — GUI privilege escalation
  security.polkit.enable = true;

  # Polkit agent for Hyprland
  environment.systemPackages = with pkgs; [
    hyprpolkitagent
    xfce.thunar
    xfce.thunar-volman        # Removable media management
    xfce.thunar-archive-plugin
  ];

  # Thunar support services
  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-volman
      thunar-archive-plugin
    ];
  };
  services.gvfs.enable = true;   # Mount, trash, and other gio ops
  services.tumbler.enable = true; # Thumbnail service

  # Session variables for Wayland
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";            # Electron apps use Wayland
    MOZ_ENABLE_WAYLAND = "1";         # Firefox Wayland
    GDK_BACKEND = "wayland,x11,*";    # GTK prefers Wayland
    QT_QPA_PLATFORM = "wayland;xcb";  # Qt prefers Wayland
    SDL_VIDEODRIVER = "wayland";
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";
  };
}
