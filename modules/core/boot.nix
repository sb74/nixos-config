{ config, pkgs, ... }:

{
  boot = {
    loader = {
      systemd-boot.enable = true;
      systemd-boot.editor = false;
      systemd-boot.configurationLimit = 10;
      efi.canTouchEfiVariables = true;
    };

    initrd.systemd.enable = true;

    kernelPackages = pkgs.linuxPackages_latest;
  };

  # Faster shutdown when services hang
  systemd.extraConfig = ''
    DefaultTimeoutStopSec=10s
  '';
}
