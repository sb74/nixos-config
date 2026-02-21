{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    obsidian
    _1password-cli
  ];
}
