{ config, pkgs, ... }:

{
  stylix = {
    enable = true;

    # ── Color Scheme ──────────────────────────────────────────
    # Tokyo Night Storm — base16 scheme
    base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-storm.yaml";

    # ── Wallpaper ─────────────────────────────────────────────
    # Stylix requires a wallpaper image to generate complementary colors
    # Replace with your own wallpaper path:
    #   stylix.image = /path/to/wallpaper.png;
    # For now, use a generated solid color image
    image = pkgs.runCommand "wallpaper.png" {
      nativeBuildInputs = [ pkgs.imagemagick ];
    } ''
      magick -size 3840x2160 \
        gradient:'#1a1b26'-'#24283b' \
        -blur 0x20 \
        $out
    '';

    # Polarity — force dark theme everywhere
    polarity = "dark";

    # ── Cursor ────────────────────────────────────────────────
    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 24;
    };

    # ── Fonts ─────────────────────────────────────────────────
    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.caskaydia-mono;
        name = "CaskaydiaMono Nerd Font";
      };
      sansSerif = {
        package = pkgs.noto-fonts;
        name = "Noto Sans";
      };
      serif = {
        package = pkgs.noto-fonts;
        name = "Noto Serif";
      };
      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
      sizes = {
        applications = 11;
        desktop = 11;
        popups = 11;
        terminal = 14;
      };
    };

    # ── Opacity ───────────────────────────────────────────────
    opacity = {
      applications = 0.97;
      desktop = 0.97;
      popups = 0.95;
      terminal = 0.95;
    };

    # ── Target Overrides ──────────────────────────────────────
    # Disable Stylix for apps with manual theming to avoid conflicts
    targets = {
      # Waybar has custom CSS with Tokyo Night colors
      waybar.enable = false;
    };
  };

  # ── GTK Theming (Home Manager) ────────────────────────────
  # Stylix handles GTK/Qt theming automatically when enabled
  # These are additional tweaks
  home-manager.users.sb74 = {
    # Hyprland has custom border/decoration colors — disable Stylix theming
    stylix.targets.hyprland.enable = false;

    gtk = {
      enable = true;
      gtk3.extraConfig = {
        gtk-application-prefer-dark-theme = true;
      };
      gtk4.extraConfig = {
        gtk-application-prefer-dark-theme = true;
      };
    };

    qt = {
      enable = true;
      platformTheme.name = "kvantum";
      style.name = "kvantum";
    };
  };
}
