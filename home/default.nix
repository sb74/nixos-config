{ config, pkgs, inputs, ... }:

{
  home.username = "sb74";
  home.homeDirectory = "/home/sb74";

  # Placeholder — modules added in later phases
  # imports = [
  #   ./shell/nushell.nix
  #   ./shell/starship.nix
  #   ./dev/git.nix
  #   ./dev/tools.nix
  #   ./desktop/hyprland.nix
  #   ./desktop/ghostty.nix
  #   ./desktop/waybar.nix
  # ];

  home.stateVersion = "25.05";
  programs.home-manager.enable = true;
}
