# nixos-config

sb74's NixOS configuration. Flakes-based, modular, multi-host.

## Structure

```
├── flake.nix               # Entry point — inputs and host definitions
├── hosts/
│   ├── testbed/            # Spare PC — test changes here first
│   ├── pc/                 # Daily driver (NVIDIA RTX 2070 Super)
│   └── laptop/             # Laptop (Intel GPU)
├── modules/
│   ├── core/               # Boot, nix daemon, networking, locale, users
│   ├── security/           # Firewall, SSH, PAM hardening, kernel sysctl
│   ├── desktop/            # Hyprland, greetd, fonts
│   ├── hardware/           # Audio, graphics, bluetooth, power
│   ├── services/           # Podman, Tailscale, btrfs snapshots
│   └── theme/              # Stylix (Tokyo Night Storm)
├── home/                   # Home Manager — user-level config
│   ├── shell/              # Nushell, starship, atuin, carapace, direnv
│   ├── desktop/            # Hyprland, Waybar, Ghostty, hyprlock, etc.
│   ├── dev/                # Git, neovim, tools
│   └── apps/               # Firefox, media
└── secrets/                # Agenix encrypted secrets
    └── secrets.nix         # Public key → secret mapping
```

## Rebuilding

```bash
# Switch to new config
nh os switch .

# Target a specific host
nh os switch --hostname testbed .

# Test without setting boot default
nh os test .

# Dry run — show what would change
nh os build .
```

## Adding a New Host

1. Create `hosts/<hostname>/` with `default.nix`, `disko.nix`, `hardware-configuration.nix`
2. Add the host to `flake.nix` outputs
3. Add host SSH public key to `secrets/secrets.nix`
4. Run `disko-install` from the NixOS ISO

## Bootstrap (First Install)

1. Boot NixOS minimal ISO
2. Clone this repo
3. Run `nix run github:nix-community/disko -- --mode disko ./hosts/<host>/disko.nix`
4. Run `nixos-install --flake .#<host>`
5. Reboot, log in with password `nixos`
6. Get host SSH key: `cat /etc/ssh/ssh_host_ed25519_key.pub`
7. Add to `secrets/secrets.nix`, encrypt password secret with agenix
8. Switch to `hashedPasswordFile` in `hosts/<host>/default.nix`, rebuild

## Secrets (Agenix)

```bash
# Create/edit a secret
cd secrets
agenix -e user-password-testbed.age

# Secrets decrypt to /run/agenix/ at activation
```
