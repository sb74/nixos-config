{ config, pkgs, ... }:

{
  networking.nftables.enable = true;

  networking.firewall = {
    enable = true;

    # Deny all inbound by default
    allowPing = false;
    allowedTCPPorts = [ ];
    allowedUDPPorts = [ ];

    # Log dropped packets (useful for debugging)
    logRefusedPackets = true;
    logRefusedUnicastsOnly = true;
  };
}
