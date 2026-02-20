{ config, ... }:

{
  # SSH client config
  # TODO: replace IPs with Unbound/OPNsense hostnames once LAN DNS is sorted
  programs.ssh = {
    enable = true;

    matchBlocks = {
      proxmox = {
        hostname = "192.168.1.214";
        user = "sb74";
      };
      nas = {
        hostname = "192.168.1.187";
        user = "sb74";
      };
      dash = {
        hostname = "192.168.1.150";
        user = "sb74";
      };
    };
  };
}
