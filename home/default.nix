{ config, pkgs, inputs, ... }:

{
  imports = [
    # Shell
    ./shell/nushell.nix
    ./shell/starship.nix
    ./shell/atuin.nix
    ./shell/carapace.nix
    ./shell/direnv.nix
    ./shell/ssh.nix
    ./shell/zellij.nix

    # Dev
    ./dev/git.nix
    ./dev/neovim.nix
    ./dev/tools.nix

    # Apps
    ./apps/browser.nix
    ./apps/gaming.nix
    ./apps/media.nix
    ./apps/misc.nix

    # Persistence
    ./impermanence.nix

    # Desktop
    ./desktop/hyprland.nix
    ./desktop/ghostty.nix
    ./desktop/waybar.nix
    ./desktop/hypridle.nix
    ./desktop/hyprlock.nix
    ./desktop/notifications.nix
    ./desktop/launcher.nix
    ./desktop/screenshots.nix
    ./desktop/clipboard.nix
    ./desktop/wayland-tools.nix
    ./desktop/wallpaper.nix
    ./desktop/nightlight.nix
  ];

  home.username = "sb74";
  home.homeDirectory = "/home/sb74";

  home.stateVersion = "25.05";
  programs.home-manager.enable = true;
}
