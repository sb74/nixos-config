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

    # Desktop
    ../../modules/desktop

    # Theme
    ../../modules/theme/stylix.nix

    # Hardware
    ../../modules/hardware/audio.nix
    ../../modules/hardware/graphics.nix  # NVIDIA — adjust package per GPU
    ../../modules/hardware/bluetooth.nix
  ];

  networking.hostName = "pc";

  # Home Manager
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
    users.sb74 = import ../../home;
  };

  system.stateVersion = "25.05";
}
