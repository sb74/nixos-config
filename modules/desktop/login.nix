{ config, pkgs, ... }:

{
  # greetd — minimal login manager
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --remember-session --sessions ${config.programs.hyprland.package}/share/wayland-sessions";
        user = "greeter";
      };
    };
  };
}
