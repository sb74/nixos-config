{ config, pkgs, ... }:

{
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
  };

  # Realtime scheduling for audio
  security.rtkit.enable = true;

  # User-level audio tools
  environment.systemPackages = with pkgs; [
    pamixer      # Volume control CLI
    playerctl    # Media player control
    wiremix      # Pipewire mixer (TUI)
    pwvucontrol  # Pipewire volume control (GUI)
  ];
}
