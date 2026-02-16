# Agenix secrets mapping
# Add SSH public keys for hosts/users that can decrypt secrets
# let
#   testbed = "ssh-ed25519 AAAA... root@testbed";
#   sb74 = "ssh-ed25519 AAAA... sb74@testbed";
# in
# {
#   "wifi.age".publicKeys = [ testbed sb74 ];
#   "user-password.age".publicKeys = [ testbed sb74 ];
# }
{ }
