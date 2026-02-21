{ config, pkgs, ... }:

{
  programs.zellij = {
    enable = true;
    enableNushellIntegration = true;
    settings = {
      default_shell = "nu";
      pane_frames = false;
      theme = "tokyo-night-storm";
      default_layout = "compact";
    };
  };
}
