{ config, pkgs, ... }:

{
  programs.atuin = {
    enable = true;
    enableNushellIntegration = true;
    enableBashIntegration = true;

    settings = {
      # Sync
      auto_sync = true;
      sync_frequency = "5m";
      sync_address = "https://api.atuin.sh";

      # Search
      search_mode = "fuzzy";
      filter_mode = "global";
      filter_mode_shell_up_key_binding = "session";
      style = "compact";
      inline_height = 20;
      show_preview = true;

      # History
      history_filter = [
        "^secret"
        "^password"
        "^token"
      ];

      # Behaviour
      enter_accept = true;
      keymap_mode = "auto";
      keymap_cursor = {
        emacs = "blink-bar";
        vim_insert = "blink-bar";
        vim_normal = "steady-block";
      };

      # Storage
      db_path = "~/.local/share/atuin/history.db";
      record_store_path = "~/.local/share/atuin/records.db";
    };
  };
}
