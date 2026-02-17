{ config, pkgs, ... }:

{
  # Walker — app launcher with prefix system
  home.packages = with pkgs; [
    walker
  ];

  # Walker config — TOML format
  xdg.configFile."walker/config.toml".text = ''
    [search]
    placeholder = "Search..."
    delay = 0
    force_keyboard_focus = true
    history = true

    [list]
    max_entries = 256
    show_initial_entries = true

    [activation_mode]
    disabled = false

    [[modules]]
    name = "applications"
    prefix = ""

    [[modules]]
    name = "websearch"
    prefix = "@"

    [[modules]]
    name = "calc"
    prefix = "="

    [[modules]]
    name = "clipboard"
    prefix = "$"

    [[modules]]
    name = "finder"
    prefix = "."

    [[modules]]
    name = "symbols"
    prefix = ":"
  '';
}
