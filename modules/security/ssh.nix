{ config, pkgs, ... }:

{
  # SSH disabled by default — enable per-host if needed
  services.openssh.enable = true;

  # If enabled elsewhere, these hardening settings apply
  services.openssh.settings = {
    PasswordAuthentication = true;
    KbdInteractiveAuthentication = false;
    PermitRootLogin = "no";
    X11Forwarding = false;

    # Modern algorithms only
    KexAlgorithms = [
      "curve25519-sha256@libssh.org"
      "diffie-hellman-group-exchange-sha256"
    ];
    Ciphers = [
      "chacha20-poly1305@openssh.com"
      "aes256-gcm@openssh.com"
      "aes128-gcm@openssh.com"
    ];
    Macs = [
      "hmac-sha2-512-etm@openssh.com"
      "hmac-sha2-256-etm@openssh.com"
    ];
  };
}
