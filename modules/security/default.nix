{ config, pkgs, ... }:

{
  imports = [
    ./auth.nix
    ./firewall.nix
    ./ssh.nix
  ];
}
