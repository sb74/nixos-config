# SSH public keys for hosts and users
# Used by secrets.nix to declare who can decrypt each secret
{
  # User key
  sb74 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAz+AsXo6OPCkckpMvOzUGSCVO28qmCNxG7bzJHtB5V1 sb74@pc";

  # Host keys — fill in after first boot on each machine:
  #   cat /etc/ssh/ssh_host_ed25519_key.pub
  testbed = "ssh-ed25519 AAAA... root@testbed";
  pc      = "ssh-ed25519 AAAA... root@pc";
  laptop  = "ssh-ed25519 AAAA... root@laptop";
}
