{ config, pkgs, ... }:

{
  # Modern CLI replacements
  programs.bat = {
    enable = true;
    config = {
      theme = "TwoDark";
      style = "numbers,changes,header";
    };
  };

  programs.eza = {
    enable = true;
    enableNushellIntegration = true;
    enableBashIntegration = true;
    icons = "auto";
    git = true;
    extraOptions = [
      "--group-directories-first"
      "--header"
      "--color=always"
    ];
  };

  # vivid — generates LS_COLORS themes for eza/ls
  programs.vivid = {
    enable = true;
    activeTheme = "tokyo-night";
  };

  programs.fd = {
    enable = true;
    hidden = true;
    extraOptions = [
      "--no-ignore-vcs"
      "--color=always"
    ];
  };

  programs.ripgrep = {
    enable = true;
    arguments = [
      "--smart-case"
      "--hidden"
      "--glob=!.git/"
    ];
  };

  programs.btop = {
    enable = true;
    settings = {
      color_theme = "tokyo-night";
      theme_background = false;
      vim_keys = true;
      rounded_corners = true;
      update_ms = 1000;
    };
  };

  programs.yazi = {
    enable = true;
    enableNushellIntegration = true;
    enableBashIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableNushellIntegration = true;
    enableBashIntegration = true;
  };

  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
    defaultCommand = "fd --type f --hidden --follow --exclude .git";
    defaultOptions = [
      "--height=40%"
      "--layout=reverse"
      "--border"
    ];
  };

  # Additional dev/CLI packages
  home.packages = with pkgs; [
    # System monitoring
    bottom         # btm — system monitor (aliased as 'top')
    dust           # du replacement
    procs          # ps replacement
    bandwhich      # bandwidth monitor

    # Dev tools
    claude-code    # AI pair programming CLI
    lazydocker     # Docker TUI
    tokei          # Code statistics
    hyperfine      # Benchmarking
    jq             # JSON processor
    yq             # YAML processor

    # File tools
    file           # File type detection
    unzip
    p7zip
    tree

    # Network tools
    curl
    wget
    dig

    # Nix tools
    nh                  # Nix helper — best-in-class rebuild wrapper
    nix-output-monitor  # nom — prettier nix build output (used by nh)
    nvd                 # Nix version diff (compare generations)
    nix-tree            # Visualise nix store deps
  ];
}
