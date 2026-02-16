{ config, pkgs, ... }:

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
    ];
    shell = pkgs.bash;
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
