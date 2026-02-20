{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    steam
    gamescope       # Micro-compositor for games (scaling, frame limiting)
    protontricks    # Winetricks wrapper for Proton
    protonup-qt     # Manage Proton-GE versions
  ];
}
