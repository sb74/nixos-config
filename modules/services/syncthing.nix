{ config, ... }:

{
  services.syncthing = {
    enable = true;
    user = "sb74";
    dataDir = "/home/sb74";
    configDir = "/persist/home/sb74/.config/syncthing";

    settings = {
      options = {
        urAccepted = -1;
        localAnnounceEnabled = true;
        globalAnnounceEnabled = true;
      };

      folders = {
        "Documents" = {
          path = "/home/sb74/Documents";
          devices = [ "nas" "pc" "laptop" "testbed" ];
        };
        "Code" = {
          path = "/home/sb74/Code";
          devices = [ "nas" "pc" "laptop" "testbed" ];
          # Ignore .git dirs — Syncthing and git don't mix well
          # Git history/state is managed by git itself on each machine
          ignores.lines = [
            ".git"
            "node_modules"
            ".direnv"
            "target"      # Rust build artifacts
            "__pycache__"
            ".venv"
          ];
        };
        # Vaults excluded — handled by Obsidian Sync
      };

      # Device IDs — fill in after running Syncthing on each machine
      # Get ID from the web UI at localhost:8384
      devices = {
        nas     = { id = "XXXXXXX-XXXXXXX-XXXXXXX-XXXXXXX-XXXXXXX-XXXXXXX-XXXXXXX-XXXXXXX"; };
        pc      = { id = "XXXXXXX-XXXXXXX-XXXXXXX-XXXXXXX-XXXXXXX-XXXXXXX-XXXXXXX-XXXXXXX"; };
        laptop  = { id = "XXXXXXX-XXXXXXX-XXXXXXX-XXXXXXX-XXXXXXX-XXXXXXX-XXXXXXX-XXXXXXX"; };
        testbed = { id = "XXXXXXX-XXXXXXX-XXXXXXX-XXXXXXX-XXXXXXX-XXXXXXX-XXXXXXX-XXXXXXX"; };
      };
    };
  };

  networking.firewall = {
    allowedTCPPorts = [ 22000 ];
    allowedUDPPorts = [ 22000 21027 ];
  };
}
