{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    protonup-qt     # Manage Proton-GE versions
  ];
}
