{ config, pkgs, ... }:

{
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      systemd-boot.configurationLimit = 10;
    };

    initrd.systemd.enable = true;

    # 6.18 matches Arch — linuxPackages_latest (6.19) breaks NVIDIA open module
    kernelPackages = pkgs.linuxKernel.packages.linux_6_18;
  };
}
