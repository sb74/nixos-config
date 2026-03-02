{ pkgs, ... }:

{
  users.users.sb74 = {
    isNormalUser = true;
    description = "Sean";
    extraGroups = [
      "wheel"
      "video"
      "audio"
      "input"
      "networkmanager"
      "podman"
      "onepassword"
    ];
    shell = pkgs.bash;
    # Ghostty launches nushell directly (command = "nu") so bash as login shell
    # is fine for desktop use. To get nushell over SSH, change to pkgs.nushell
    # and ensure it's in /etc/shells (programs.nushell.enable handles this).

    # Bootstrap password — change after first boot:
    #   1. Get host SSH key: cat /etc/ssh/ssh_host_ed25519_key.pub
    #   2. Add to secrets/secrets.nix
    #   3. Generate hash: mkpasswd -m sha-512 | agenix -e user-password.age
    #   4. Switch to: hashedPasswordFile = config.age.secrets.user-password.path;
    initialPassword = "nixos";
  };

  # doas instead of sudo
  security.doas = {
    enable = true;
    extraRules = [
      {
        groups = [ "wheel" ];
        persist = true;
        keepEnv = true;
      }
    ];
  };
  security.sudo.enable = false;
}
