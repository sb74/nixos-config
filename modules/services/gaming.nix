{ config, pkgs, ... }:

{
  # Steam — system-level setup for 32-bit libs + controller support
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = false;
    gamescopeSession.enable = true;
  };

  # GameMode — lets games request performance governor
  programs.gamemode.enable = true;
}
