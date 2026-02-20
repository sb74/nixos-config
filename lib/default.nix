{ inputs, lib, ... }:

{
  # enabled / disabled — shorthand for { enable = true/false; }
  # Usage: services.tailscale = lib.enabled;
  enabled  = { enable = true; };
  disabled = { enable = false; };

  # merge — composable mkMerge wrapper
  # Usage: lib.merge [ { a = 1; } { b = 2; } ]
  merge = lib.mkMerge;

  # collectNix — recursively collect all .nix files under a path
  # Usage: imports = lib.collectNix ./modules/core;
  collectNix = path:
    lib.filter (lib.hasSuffix ".nix") (lib.filesystem.listFilesRecursive path);

  # mkHost — standard host builder (expand as needed)
  mkHost = { system ? "x86_64-linux", modules, specialArgs ? {} }:
    inputs.nixpkgs.lib.nixosSystem {
      inherit system specialArgs modules;
    };
}
