{ config, ... }:

{
  # Home-level persistence — declared paths survive root rollback via bind mounts
  home.persistence."/persist/home/sb74" = {
    allowOther = true;

    directories = [
      # Identity & auth
      ".ssh"
      ".gnupg"
      ".local/share/keyrings"

      # Shell history
      ".local/share/atuin"

      # Dev tools state
      ".local/share/nvim"       # Neovim plugins/state
      ".config/lazygit"

      # Desktop state
      ".local/share/walker"     # Launcher history

      # Browsers
      ".mozilla/firefox"

      # Apps
      ".config/obsidian"
      ".config/spotify"
      ".config/1Password"

      # Personal files
      "Documents"
      "Downloads"
      "Code"
      "Vaults"
    ];

    files = [
      ".config/atuin/config.toml"
    ];
  };
}
