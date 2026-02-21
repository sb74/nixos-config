{ config, pkgs, lib, ... }:

let
  showKeybinds = pkgs.writeShellScript "hypr-keybinds" ''
    hyprctl binds -j | ${pkgs.jq}/bin/jq -r '
      ["# Keybindings", ""] +
      [.[] | select(.description != "") |
        "- **\(.modmask) + \(.key)**: \(.description)"]
      | join("\n")
    ' | ${pkgs.glow}/bin/glow -
    read -n1
  '';
in

{
  wayland.windowManager.hyprland = {
    enable = true;

    # Don't enable systemd integration — UWSM handles it
    systemd.enable = false;

    settings = {
      # ── Monitors ──────────────────────────────────────────────
      # Auto-detect — override per-host via host-specific config
      monitor = ",preferred,auto,auto";

      # ── General ───────────────────────────────────────────────
      general = {
        gaps_in = 4;
        gaps_out = 8;
        border_size = 2;
        "col.active_border" = "rgba(33ccffcc) rgba(00ff99cc) 45deg";
        "col.inactive_border" = "rgba(44445588)";
        layout = "dwindle";
      };

      # ── Input ─────────────────────────────────────────────────
      input = {
        repeat_rate = 50;
        repeat_delay = 350;
        touchpad = {
          scroll_factor = 0.4;
          natural_scroll = true;
        };
      };

      # ── Decoration ────────────────────────────────────────────
      decoration = {
        rounding = 10;
        blur = {
          enabled = true;
          size = 6;
          passes = 3;
          new_optimizations = true;
          xray = false;
        };
        shadow = {
          enabled = true;
          range = 12;
          render_power = 3;
          color = "rgba(0000003a)";
        };
      };

      # ── Animations (spring beziers + slide) ───────────────────
      bezier = [
        "wind, 0.05, 0.9, 0.1, 1.05"
        "winIn, 0.1, 1.1, 0.1, 1.0"
        "winOut, 0.3, -0.3, 0, 1"
        "liner, 1, 1, 1, 1"
      ];

      animation = [
        "windows, 1, 6, wind, slide"
        "windowsIn, 1, 5, winIn, slide"
        "windowsOut, 1, 3, winOut, slide"
        "windowsMove, 1, 5, wind, slide"
        "fade, 1, 5, wind"
        "workspaces, 1, 5, wind, slide"
        "border, 1, 10, liner"
        "layers, 1, 4, wind, fade"
      ];

      # ── Layout ────────────────────────────────────────────────
      dwindle = {
        pseudotile = true;
        preserve_split = true;
        force_split = 2;
      };

      # ── Misc ──────────────────────────────────────────────────
      misc = {
        mouse_move_focuses_monitor = false;
        focus_on_activate = true;
        disable_hyprland_logo = true;
      };

      # ── Window Rules ──────────────────────────────────────────
      windowrulev2 = [
        "suppressevent maximize, class:.*"
        "opacity 0.97 0.9, class:.*"
        # Keybind cheat sheet popup
        "float, class:hyprkeys"
        "size 900 600, class:hyprkeys"
        "center, class:hyprkeys"
      ];

      # ── Autostart ─────────────────────────────────────────────
      exec-once = [
        "waybar"
        "swaync"
        "hyprpaper"
        "systemctl --user start hyprpolkitagent"
        "wl-clip-persist --clipboard regular"
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
      ];

      # ── Environment ───────────────────────────────────────────
      env = [
        "XCURSOR_SIZE,24"
        "HYPRCURSOR_SIZE,24"
      ];

      # ── Keybindings ───────────────────────────────────────────

      "$mod" = "SUPER";

      bind = [
        # ── App Launchers ──
        "$mod, RETURN, exec, uwsm app -- ghostty"
        "$mod SHIFT, F, exec, thunar"
        "$mod SHIFT, B, exec, firefox"
        "$mod SHIFT ALT, B, exec, firefox --private-window"
        "$mod SHIFT, M, exec, spotify"
        "$mod SHIFT, N, exec, uwsm app -- ghostty -e nvim"
        "$mod SHIFT, T, exec, uwsm app -- ghostty -e btop"
        "$mod SHIFT, D, exec, uwsm app -- ghostty -e lazydocker"
        "$mod SHIFT, O, exec, obsidian --disable-gpu --enable-wayland-ime"
        "$mod SHIFT, slash, exec, 1password"

        # ── Web Apps (Firefox) ──
        "$mod SHIFT, A, exec, firefox --new-window https://chatgpt.com"
        "$mod SHIFT ALT, A, exec, firefox --new-window https://grok.com"
        "$mod SHIFT, C, exec, firefox --new-window https://app.hey.com/calendar"
        "$mod SHIFT, E, exec, firefox --new-window https://app.hey.com"
        "$mod SHIFT, Y, exec, firefox --new-window https://youtube.com"
        "$mod SHIFT ALT, G, exec, firefox --new-window https://web.whatsapp.com"
        "$mod SHIFT CTRL, G, exec, firefox --new-window https://messages.google.com"
        "$mod SHIFT, X, exec, firefox --new-window https://x.com"
        "$mod SHIFT ALT, X, exec, firefox --new-window https://x.com/compose/post"

        # ── Window Management ──
        "$mod, W, killactive"
        "CTRL ALT, DELETE, exec, hyprctl dispatch closewindow"
        "$mod, J, togglesplit"
        "$mod, P, pseudo"
        "$mod, T, togglefloating"
        "$mod, F, fullscreen, 0"
        "$mod CTRL, F, fullscreen, 1"
        "$mod ALT, F, fullscreenstate, -1 2"
        "$mod, O, pin"

        # ── Focus ──
        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"
        "ALT, TAB, cyclenext"
        "ALT SHIFT, TAB, cyclenext, prev"

        # ── Workspaces ──
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"

        # ── Move to Workspace ──
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"
        "$mod SHIFT, 0, movetoworkspace, 10"

        # ── Move Silently ──
        "$mod SHIFT ALT, 1, movetoworkspacesilent, 1"
        "$mod SHIFT ALT, 2, movetoworkspacesilent, 2"
        "$mod SHIFT ALT, 3, movetoworkspacesilent, 3"
        "$mod SHIFT ALT, 4, movetoworkspacesilent, 4"
        "$mod SHIFT ALT, 5, movetoworkspacesilent, 5"
        "$mod SHIFT ALT, 6, movetoworkspacesilent, 6"
        "$mod SHIFT ALT, 7, movetoworkspacesilent, 7"
        "$mod SHIFT ALT, 8, movetoworkspacesilent, 8"
        "$mod SHIFT ALT, 9, movetoworkspacesilent, 9"
        "$mod SHIFT ALT, 0, movetoworkspacesilent, 10"

        # ── Workspace Navigation ──
        "$mod, TAB, workspace, m+1"
        "$mod SHIFT, TAB, workspace, m-1"
        "$mod CTRL, TAB, workspace, previous"

        # ── Scratchpad ──
        "$mod, S, togglespecialworkspace, scratchpad"
        "$mod ALT, S, movetoworkspace, special:scratchpad"

        # ── Multi-Monitor ──
        "$mod SHIFT ALT, left, movecurrentworkspacetomonitor, l"
        "$mod SHIFT ALT, right, movecurrentworkspacetomonitor, r"

        # ── Window Swap ──
        "$mod SHIFT, left, swapwindow, l"
        "$mod SHIFT, right, swapwindow, r"
        "$mod SHIFT, up, swapwindow, u"
        "$mod SHIFT, down, swapwindow, d"

        # ── Resize ──
        "$mod, minus, splitratio, -0.1"
        "$mod, equal, splitratio, +0.1"

        # ── Groups ──
        "$mod, G, togglegroup"
        "$mod ALT, G, moveoutofgroup"
        "$mod ALT, TAB, changegroupactive, f"
        "$mod CTRL, left, changegroupactive, b"
        "$mod CTRL, right, changegroupactive, f"

        # ── Launcher ──
        "$mod, SPACE, exec, walker"
        "$mod, F1, exec, ghostty --class=hyprkeys -e ${showKeybinds}"

        # ── Clipboard ──
        "$mod, C, exec, wtype -M ctrl -k Insert -m ctrl"
        "$mod, V, exec, wtype -M shift -k Insert -m shift"
        "$mod, X, exec, wtype -M ctrl -k x -m ctrl"
        "$mod CTRL, V, exec, cliphist list | walker --dmenu | cliphist decode | wl-copy"

        # ── Notifications (swaync) ──
        "$mod, comma, exec, swaync-client -C -sw"
        "$mod SHIFT, comma, exec, swaync-client --close-all"
        "$mod CTRL, comma, exec, swaync-client -d -sw"
        "$mod ALT, comma, exec, swaync-client -t -sw"

        # ── Captures ──
        ", Print, exec, grim -g \"$(slurp)\" - | satty --filename -"
        "SHIFT, Print, exec, grim -g \"$(slurp)\" - | wl-copy"
        "$mod, Print, exec, hyprpicker -a"

        # ── System ──
        "$mod CTRL, L, exec, hyprlock"
        "$mod SHIFT, SPACE, exec, pkill -SIGUSR1 waybar"

        # ── Bar/Aesthetics ──
        "$mod, BACKSPACE, exec, hyprctl keyword decoration:active_opacity $(hyprctl getoption decoration:active_opacity | grep float | awk '{if ($2 == 1.0) print 0.97; else print 1.0}')"
      ];

      # ── Mouse Bindings ──
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      # ── Media Keys ──
      bindel = [
        ", XF86AudioRaiseVolume, exec, swayosd-client --output-volume raise"
        ", XF86AudioLowerVolume, exec, swayosd-client --output-volume lower"
        ", XF86MonitorBrightnessUp, exec, swayosd-client --brightness raise"
        ", XF86MonitorBrightnessDown, exec, swayosd-client --brightness lower"
        "ALT, XF86AudioRaiseVolume, exec, swayosd-client --output-volume +1"
        "ALT, XF86AudioLowerVolume, exec, swayosd-client --output-volume -1"
        "ALT, XF86MonitorBrightnessUp, exec, swayosd-client --brightness +1"
        "ALT, XF86MonitorBrightnessDown, exec, swayosd-client --brightness -1"
      ];

      bindl = [
        ", XF86AudioMute, exec, swayosd-client --output-volume mute-toggle"
        ", XF86AudioMicMute, exec, swayosd-client --input-volume mute-toggle"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPrev, exec, playerctl previous"
        "$mod, XF86AudioMute, exec, swayosd-client --output-volume toggle-default"
      ];
    };
  };
}
