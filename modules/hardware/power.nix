{ config, pkgs, ... }:

{
  # Power management — laptop-oriented
  services.power-profiles-daemon.enable = true;

  # Battery/power monitoring
  services.upower = {
    enable = true;
    percentageLow = 15;
    percentageCritical = 5;
    percentageAction = 2;
    criticalPowerAction = "HybridSleep";
  };

  # Lid behaviour + logout cleanup
  services.logind = {
    lidSwitch = "suspend";
    lidSwitchExternalPower = "lock";
    lidSwitchDocked = "ignore";
    killUserProcesses = true;
  };

  # Thermald for Intel CPUs
  services.thermald.enable = true;
}
