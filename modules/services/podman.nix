{ config, pkgs, ... }:

{
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;  # docker CLI → podman symlink
    defaultNetwork.settings.dns_enabled = true;  # container DNS resolution
  };

  # User namespaces for rootless containers
  security.unprivilegedUsernsClone = true;

  environment.systemPackages = with pkgs; [
    docker-compose
  ];
}
