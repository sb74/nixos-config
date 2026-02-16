{ config, pkgs, ... }:

{
  imports = [
    ./firewall.nix
    ./ssh.nix
  ];
}
