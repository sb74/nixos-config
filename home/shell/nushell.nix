{ config, pkgs, ... }:

{
  # Nushell as interactive shell
  programs.nushell = {
    enable = true;

    # Config loaded into config.nu
    extraConfig = ''
      # Nushell configuration

      $env.config = {
        show_banner: false

        ls: {
          use_ls_colors: true
          clickable_links: true
        }

        table: {
          mode: rounded
          index_mode: auto
        }

        completions: {
          case_sensitive: false
          quick: true
          partial: true
          algorithm: "fuzzy"
        }

        history: {
          max_size: 100_000
          sync_on_enter: true
          file_format: "sqlite"
        }

        cursor_shape: {
          emacs: line
          vi_insert: line
          vi_normal: block
        }
      }
    '';

    # Environment config loaded into env.nu
    extraEnv = ''
      $env.EDITOR = "nvim"
      $env.TERMINAL = "ghostty"
    '';

    # Aliases
    shellAliases = {
      ll = "ls -l";
      la = "ls -la";
      cat = "bat";
      find = "fd";
      grep = "rg";
      top = "btm";
      du = "dust";
      ps = "procs";
    };
  };

  # Bash as login shell — execs nushell for interactive sessions
  # This ensures NixOS environment is sourced correctly
  programs.bash = {
    enable = true;
    initExtra = ''
      # If running interactively and nushell is available, exec into it
      if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "nu" && -z ''${BASH_EXECUTION_STRING} ]]; then
        shopt -s expand_aliases
        exec ${pkgs.nushell}/bin/nu
      fi
    '';
  };
}
