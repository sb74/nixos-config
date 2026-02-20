{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    extraPackages = with pkgs; [
      # LSP servers
      lua-language-server
      nil              # Nix LSP
      nodePackages.typescript-language-server
      pyright          # Python LSP
      rust-analyzer

      # Tools used by plugins
      ripgrep
      fd
    ];
  };
}
