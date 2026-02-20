{ config, pkgs, ... }:

{
  programs.ghostty = {
    enable = true;

    settings = {
      # Font
      font-family = "CaskaydiaMono Nerd Font";
      font-style = "Regular";
      font-size = 14;
      bold-is-bright = true;

      # Shell — nushell
      command = "nu";

      # Window
      window-padding-x = 14;
      window-padding-y = 14;
      window-padding-balance = true;
      window-theme = "ghostty";
      window-decoration = false;
      confirm-close-surface = false;
      resize-overlay = "never";

      # Cursor
      cursor-style = "block";
      cursor-style-blink = false;

      # Clipboard
      copy-on-select = "clipboard";
      clipboard-paste-protection = false;

      # Shell integration
      shell-integration-features = "no-cursor,ssh-env";

      # Scrollback
      scrollback-limit = 50000;
      mouse-scroll-multiplier = 3;

      # Keybinds
      keybind = [
        "f11=toggle_fullscreen"
        "shift+insert=paste_from_clipboard"
        "ctrl+insert=copy_to_clipboard"
      ];
    };
  };
}
