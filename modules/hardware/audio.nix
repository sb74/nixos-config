{ config, pkgs, ... }:

{
  # Disable audio power saving to prevent crackling
  boot.extraModprobeConfig = ''
    options snd_hda_intel power_save=0
  '';

  # PipeWire replaces PulseAudio
  services.pipewire = {
    enable = true;

    alsa = {
      enable = true;
      support32Bit = true;
    };

    jack.enable = true;
    pulse.enable = true;

    # WirePlumber as session manager
    wireplumber.enable = true;

    # Low-latency config for gaming/audio production
    extraConfig.pipewire."99-low-latency" = {
      context.properties = {
        default.clock = {
          rate = 48000;
          quantum = 512;
          min-quantum = 256;
          max-quantum = 8192;
        };
      };
    };
  };

  # Realtime scheduling for audio
  security.rtkit.enable = true;

  # User-level audio tools
  environment.systemPackages = with pkgs; [
    pamixer      # Volume control CLI
    wiremix      # Pipewire mixer (TUI)
  ];
}
