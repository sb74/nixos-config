{ config, pkgs, ... }:

{
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;  # Fast nix-shell/flake integration

    # Nushell integration handled via config
    enableNushellIntegration = true;
    enableBashIntegration = true;

    config = {
      global = {
        warn_timeout = "30s";
        hide_env_diff = true;  # Less noise in shell output
      };
    };
  };
}
