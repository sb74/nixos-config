{ config, pkgs, ... }:

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

    # Use the beta package for latest features (or stable)
    package = config.boot.kernelPackages.nvidiaPackages.beta;
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
