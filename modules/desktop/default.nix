{ config, pkgs, ... }:

{
  imports = [
    ./hyprland.nix
    ./login.nix
    ./fonts.nix
  ];
}
