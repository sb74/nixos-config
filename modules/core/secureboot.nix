{ config, pkgs, inputs, ... }:

{
  # Lanzaboote — secure boot for NixOS
  # Replaces systemd-boot after key enrolment
  #
  # Setup (one-time, per machine):
  #   1. Boot with Secure Boot in Setup Mode (clear keys in UEFI)
  #   2. Install sbctl: nix shell nixpkgs#sbctl
  #   3. Create keys: sbctl create-keys
  #   4. Enrol keys:  sbctl enroll-keys --microsoft (keep MS keys for UEFI compat)
  #   5. Enable this module and rebuild
  #   6. Verify: sbctl verify

  boot.loader.systemd-boot.enable = false;  # Lanzaboote takes over

  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/persist/etc/secureboot";  # Keys persist across root rollbacks
  };

  environment.systemPackages = [ pkgs.sbctl ];
}
