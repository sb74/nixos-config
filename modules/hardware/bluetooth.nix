{ config, pkgs, ... }:

{
  # Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;

    settings = {
      General = {
        # Modern pairing
        FastConnectable = true;
        # Battery reporting for BLE devices
        Experimental = true;
      };
    };
  };

  # D-Bus service for BT
  services.blueman.enable = true;

  # TUI bluetooth manager
  environment.systemPackages = with pkgs; [
    bluetui
  ];
}
