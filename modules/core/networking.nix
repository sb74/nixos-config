{ config, pkgs, ... }:

{
  networking = {
    networkmanager.enable = true;

    # Disable LLMNR
    networkmanager.connectionConfig."connection.llmnr" = "no";

    # Firewall — deny all inbound by default
    firewall = {
      enable = true;
      allowedTCPPorts = [ ];
      allowedUDPPorts = [ ];
    };
  };

  # DNS — use NUC's Unbound as primary, public as fallback
  networking.nameservers = [ "192.168.1.1" ];

  services.resolved = {
    enable = true;
    settings.Resolve = {
      DNSSEC = "allow-downgrade";
      FallbackDNS = "1.1.1.1 9.9.9.9";
    };
  };
}
