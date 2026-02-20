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
    ../../modules/core/impermanence.nix
    ../../modules/core/secureboot.nix

    # Security
    ../../modules/security

    # Desktop
    ../../modules/desktop

    # Services
    ../../modules/services
    ../../modules/services/gaming.nix

    # Theme
    ../../modules/theme/stylix.nix

    # Hardware
    ../../modules/hardware/audio.nix
    ../../modules/hardware/graphics.nix  # RTX 3070 LHR
    ../../modules/hardware/bluetooth.nix
  ];

  networking.hostName = "pc";

  # Agenix secrets — uncomment after first boot once host SSH key is in secrets.nix
  # age.secrets.user-password.file = ../../secrets/user-password-pc.age;

  # Home Manager
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
    users.sb74 = import ../../home;
  };

  system.stateVersion = "25.05";
}
