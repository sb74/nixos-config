{ config, pkgs, lib, ... }:

{
  # Steam — system-level setup for 32-bit libs + controller support
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = false;
    localNetworkGameTransfers.openFirewall = true;

    # Proton extras
    protontricks.enable = true;
    extraCompatPackages = [ pkgs.proton-ge-bin ];

    # Steam controller support
    extest.enable = true;
  };

  # GameMode — lets games request performance governor
  programs.gamemode = {
    enable = true;
    enableRenice = true;
    settings = {
      general = {
        softrealtime = "auto";
        renice = 15;
      };
    };
  };

  # Gamescope — use per-game via: gamescope -W 1920 -H 1080 -f -- %command%
  # Not using gamescopeSession (Steam Deck style) since we're on Hyprland desktop
  programs.gamescope = {
    enable = true;
    capSysNice = true;
  };

  # NTSync — fast Windows-compatible sync for Wine/Proton (kernel 6.14+)
  boot.kernelModules = lib.mkIf (lib.versionAtLeast config.boot.kernelPackages.kernel.version "6.14") [ "ntsync" ];

  # Udev rule for ntsync device access
  services.udev.extraRules = lib.mkIf (lib.versionAtLeast config.boot.kernelPackages.kernel.version "6.14") ''
    KERNEL=="ntsync", MODE="0660", TAG+="uaccess"
  '';

  # Extra tools
  environment.systemPackages = [ pkgs.steamtinkerlaunch ];

  # Kernel optimizations for gaming
  boot.kernel.sysctl = {
    # Scheduler tuning (Steam Deck uses similar)
    "kernel.sched_cfs_bandwidth_slice_us" = 3000;

    # Faster TCP port reuse for games that restart quickly
    "net.ipv4.tcp_fin_timeout" = 5;

    # Prevent intentional slowdowns from split locks
    "kernel.split_lock_mitigate" = 0;

    # Some games need high map count (e.g., Hogwarts Legacy)
    "vm.max_map_count" = 2147483642;
  };
}
