{ config, pkgs, inputs, ... }:

{
  # Ensure btrfs tools are available in initrd
  boot.initrd.supportedFilesystems = [ "btrfs" ];

  # Roll back root to blank snapshot on every boot
  boot.initrd.systemd.services.rollback = {
    description = "Rollback root filesystem to blank snapshot";
    wantedBy = [ "initrd.target" ];
    after = [ "dev-mapper-cryptroot.device" ];
    before = [ "sysroot.mount" ];
    unitConfig.DefaultDependencies = "no";
    serviceConfig.Type = "oneshot";
    script = ''
      mkdir -p /mnt
      mount -t btrfs -o subvol=/ /dev/mapper/cryptroot /mnt
      btrfs subvolume delete /mnt/@
      btrfs subvolume snapshot /mnt/@root-blank /mnt/@
      umount /mnt
    '';
  };

  # Required by impermanence — persistence paths must be available early
  fileSystems."/persist".neededForBoot = true;
  fileSystems."/home".neededForBoot = true;

  # System-level persistence — everything here survives reboots
  environment.persistence."/persist" = {
    hideMounts = true;

    directories = [
      "/etc/NetworkManager/system-connections"
      "/var/log"
      "/var/lib/bluetooth"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
      "/var/lib/tailscale"
    ];

    files = [
      "/etc/machine-id"
      "/etc/ssh/ssh_host_ed25519_key"
      "/etc/ssh/ssh_host_ed25519_key.pub"
      "/etc/ssh/ssh_host_rsa_key"
      "/etc/ssh/ssh_host_rsa_key.pub"
    ];
  };
}
