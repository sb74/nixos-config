{ ... }:

{
  # TPM2 userspace support
  security.tpm2 = {
    enable = true;
    pkcs11.enable = true;
    tctiEnvironment.enable = true;
  };

  # Tell systemd initrd to use TPM2 when unlocking cryptroot.
  # Requires the TPM2 key slot to be enrolled first (one-time, per machine):
  #
  #   # Verify TPM is present:
  #   systemd-cryptenroll --tpm2-device=list
  #
  #   # Enroll TPM2 key bound to PCR 7 (Secure Boot state):
  #   sudo systemd-cryptenroll --tpm2-device=auto --tpm2-pcrs=7 /dev/nvme0n1p2
  #   (replace /dev/nvme0n1p2 with the actual LUKS partition — check with lsblk)
  #
  #   # Reboot — should unlock without passphrase. Passphrase slot is kept as fallback.
  #
  #   # To re-enroll after Secure Boot key changes (e.g. sbctl re-key):
  #   sudo systemd-cryptenroll --wipe-slot=tpm2 /dev/nvme0n1p2
  #   sudo systemd-cryptenroll --tpm2-device=auto --tpm2-pcrs=7 /dev/nvme0n1p2
  #
  #   # Verify slots:
  #   sudo cryptsetup luksDump /dev/nvme0n1p2 | grep -A3 "Keyslots"
  boot.initrd.luks.devices."cryptroot".crypttabExtraOpts = [ "tpm2-device=auto" ];
}
