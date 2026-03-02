{ config, pkgs, ... }:

{
  # Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    package = pkgs.bluez-experimental;

    settings = {
      General = {
        # Modern pairing
        FastConnectable = true;
        # Battery reporting for BLE devices
        Experimental = true;
        # Easier device pairing
        JustWorksRepairing = "always";
        # Multi-device support (headphones + keyboard etc.)
        MultiProfile = "multiple";
        KernelExperimental = true;
      };
      Policy = {
        # Auto-reconnect on disconnect
        ReconnectAttempts = 7;
        ReconnectIntervals = "1,2,4,8,16,32,64";
      };
    };
  };

  # Load bluetooth USB kernel module
  boot.kernelModules = [ "btusb" ];

  # D-Bus service for BT
  services.blueman.enable = true;

  # TUI bluetooth manager
  environment.systemPackages = with pkgs; [
    bluetui
  ];
}
