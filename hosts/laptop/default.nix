{ config, pkgs, inputs, ... }:

{
  imports = [
    ./disko.nix
    ./hardware-configuration.nix

    # Core
    ../../modules/core/boot.nix
    ../../modules/core/nix.nix
    ../../modules/core/networking.nix
    ../../modules/core/locale.nix
    ../../modules/core/users.nix

    # Security
    ../../modules/security

    # Hardware
    ../../modules/hardware/audio.nix
    ../../modules/hardware/bluetooth.nix
    ../../modules/hardware/power.nix
    # No NVIDIA — Intel integrated graphics (Mesa)
  ];

  networking.hostName = "laptop";

  # Intel GPU — Mesa handles everything
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # Home Manager
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
    users.sb74 = import ../../home;
  };

  system.stateVersion = "25.05";
}
