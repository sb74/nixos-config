{ config, pkgs, ... }:

{
  programs.mpv = {
    enable = true;
    config = {
      profile = "gpu-hq";
      hwdec = "auto-safe";
      vo = "gpu";
      gpu-api = "vulkan";
    };
  };

  home.packages = with pkgs; [
    imv        # Image viewer
    spotify
    kdePackages.kdenlive   # Video editor
    pinta      # Image editor
  ];
}
