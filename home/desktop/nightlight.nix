{ config, pkgs, ... }:

{
  # Gammastep — night light (replaces sunsetr)
  services.gammastep = {
    enable = true;
    provider = "manual";

    # Glasgow coordinates
    latitude = 55.833333;
    longitude = -4.250000;

    # Color temperature
    temperature = {
      day = 6500;
      night = 3300;
    };

    settings = {
      general = {
        fade = 1;              # Smooth transition
        adjustment-method = "wayland";
      };
    };
  };
}
