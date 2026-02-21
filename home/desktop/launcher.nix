{ config, pkgs, inputs, ... }:

{
  imports = [ inputs.walker.homeManagerModules.default ];

  programs.walker = {
    enable = true;
    runAsService = true;

    config = {
      search = {
        placeholder = "Search...";
        delay = 0;
        force_keyboard_focus = true;
        history = true;
      };

      list = {
        max_entries = 256;
        show_initial_entries = true;
      };

      activation_mode.disabled = false;

      # Prefix-based module routing
      modules = [
        { name = "applications"; prefix = ""; }
        { name = "websearch";    prefix = "@"; }
        { name = "calc";         prefix = "="; }
        { name = "clipboard";    prefix = "$"; }
        { name = "finder";       prefix = "."; }
        { name = "symbols";      prefix = ":"; }
        { name = "runner";       prefix = "!"; }  # elephant AI search
      ];
    };
  };
}
