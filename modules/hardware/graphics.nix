{ config, pkgs, lib, ... }:

{
  # Enable OpenGL
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # NVIDIA configuration
  hardware.nvidia = {
    modesetting.enable = true;

    # Open-source kernel module (for Turing+ GPUs — RTX 20xx and newer)
    open = true;

    # NVIDIA settings GUI
    nvidiaSettings = true;

    # Power management for suspend/resume
    powerManagement = {
      enable = true;
      finegrained = false;
    };

    # 580.126.18 fixes kernel 6.19 open module build — use until nixpkgs picks it up
    package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
      version = "580.126.18";
      sha256_64bit = "sha256-p3gbLhwtZcZYCRTHbnntRU0ClF34RxHAMwcKCSqatJ0=";
      sha256_aarch64 = "sha256-pruxWQlLurymRL7PbR24NA6dNowwwX35p6j9mBIDcNs=";
      openSha256 = "sha256-1Q2wuDdZ6KiA/2L3IDN4WXF8t63V/4+JfrFeADI1Cjg=";
      settingsSha256 = "sha256-QMx4rUPEGp/8Mc+Bd8UmIet/Qr0GY8bnT/oDN8GAoEI=";
      persistencedSha256 = lib.fakeSha256;
    };
  };

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = [ "nvidia" ];

  # Environment variables for Wayland + NVIDIA
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "nvidia";
    XDG_SESSION_TYPE = "wayland";
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    NIXOS_OZONE_WL = "1";
  };

  # Extra packages for NVIDIA + Wayland
  environment.systemPackages = with pkgs; [
    egl-wayland
    nvidia-vaapi-driver  # VAAPI hardware video decode/encode via NVIDIA
  ];
}
