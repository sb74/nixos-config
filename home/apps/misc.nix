{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    obsidian
    _1password-gui
    _1password-cli  # CLI
  ];
}
