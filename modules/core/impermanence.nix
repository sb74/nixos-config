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

  # FUSE — allow_other needed for home persistence bind mounts
  programs.fuse.userAllowOther = true;

  # Wire home-manager impermanence module into all users
  home-manager.sharedModules = [
    inputs.impermanence.nixosModules.home-manager.impermanence
  ];

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
