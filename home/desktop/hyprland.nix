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

      bindd = [
        # ── App Launchers ──
        "$mod, RETURN, Open terminal, exec, uwsm app -- ghostty"
        "$mod SHIFT, F, Open file manager, exec, thunar"
        "$mod SHIFT, B, Open browser, exec, firefox"
        "$mod SHIFT ALT, B, Open private browser, exec, firefox --private-window"
        "$mod SHIFT, M, Open music, exec, spotify"
        "$mod SHIFT, N, Open editor, exec, uwsm app -- ghostty -e nvim"
        "$mod SHIFT, T, Open system monitor, exec, uwsm app -- ghostty -e btop"
        "$mod SHIFT, D, Open Docker TUI, exec, uwsm app -- ghostty -e lazydocker"
        "$mod SHIFT, O, Open Obsidian, exec, obsidian --disable-gpu --enable-wayland-ime"
        "$mod SHIFT, slash, Open 1Password, exec, 1password"

        # ── Web Apps ──
        "$mod SHIFT, A, Open ChatGPT, exec, firefox --new-window https://chatgpt.com"
        "$mod SHIFT ALT, A, Open Grok, exec, firefox --new-window https://grok.com"
        "$mod SHIFT, C, Open calendar, exec, firefox --new-window https://app.hey.com/calendar"
        "$mod SHIFT, E, Open email, exec, firefox --new-window https://app.hey.com"
        "$mod SHIFT, Y, Open YouTube, exec, firefox --new-window https://youtube.com"
        "$mod SHIFT ALT, G, Open WhatsApp, exec, firefox --new-window https://web.whatsapp.com"
        "$mod SHIFT CTRL, G, Open Google Messages, exec, firefox --new-window https://messages.google.com"
        "$mod SHIFT, X, Open X, exec, firefox --new-window https://x.com"
        "$mod SHIFT ALT, X, Compose post, exec, firefox --new-window https://x.com/compose/post"

        # ── Window Management ──
        "$mod, W, Close window, killactive"
        "CTRL ALT, DELETE, Force close window, exec, hyprctl dispatch closewindow"
        "$mod, J, Toggle split, togglesplit"
        "$mod, P, Toggle pseudo-tile, pseudo"
        "$mod, T, Toggle floating, togglefloating"
        "$mod, F, Fullscreen, fullscreen, 0"
        "$mod CTRL, F, Maximize, fullscreen, 1"
        "$mod ALT, F, Fake fullscreen, fullscreenstate, -1 2"
        "$mod, O, Pin window, pin"

        # ── Focus ──
        "$mod, left, Focus left, movefocus, l"
        "$mod, right, Focus right, movefocus, r"
        "$mod, up, Focus up, movefocus, u"
        "$mod, down, Focus down, movefocus, d"
        "ALT, TAB, Cycle next window, cyclenext"
        "ALT SHIFT, TAB, Cycle previous window, cyclenext, prev"

        # ── Workspaces ──
        "$mod, 1, Switch to workspace 1, workspace, 1"
        "$mod, 2, Switch to workspace 2, workspace, 2"
        "$mod, 3, Switch to workspace 3, workspace, 3"
        "$mod, 4, Switch to workspace 4, workspace, 4"
        "$mod, 5, Switch to workspace 5, workspace, 5"
        "$mod, 6, Switch to workspace 6, workspace, 6"
        "$mod, 7, Switch to workspace 7, workspace, 7"
        "$mod, 8, Switch to workspace 8, workspace, 8"
        "$mod, 9, Switch to workspace 9, workspace, 9"
        "$mod, 0, Switch to workspace 10, workspace, 10"

        # ── Move to Workspace ──
        "$mod SHIFT, 1, Move to workspace 1, movetoworkspace, 1"
        "$mod SHIFT, 2, Move to workspace 2, movetoworkspace, 2"
        "$mod SHIFT, 3, Move to workspace 3, movetoworkspace, 3"
        "$mod SHIFT, 4, Move to workspace 4, movetoworkspace, 4"
        "$mod SHIFT, 5, Move to workspace 5, movetoworkspace, 5"
        "$mod SHIFT, 6, Move to workspace 6, movetoworkspace, 6"
        "$mod SHIFT, 7, Move to workspace 7, movetoworkspace, 7"
        "$mod SHIFT, 8, Move to workspace 8, movetoworkspace, 8"
        "$mod SHIFT, 9, Move to workspace 9, movetoworkspace, 9"
        "$mod SHIFT, 0, Move to workspace 10, movetoworkspace, 10"

        # ── Move Silently ──
        "$mod SHIFT ALT, 1, Move silently to workspace 1, movetoworkspacesilent, 1"
        "$mod SHIFT ALT, 2, Move silently to workspace 2, movetoworkspacesilent, 2"
        "$mod SHIFT ALT, 3, Move silently to workspace 3, movetoworkspacesilent, 3"
        "$mod SHIFT ALT, 4, Move silently to workspace 4, movetoworkspacesilent, 4"
        "$mod SHIFT ALT, 5, Move silently to workspace 5, movetoworkspacesilent, 5"
        "$mod SHIFT ALT, 6, Move silently to workspace 6, movetoworkspacesilent, 6"
        "$mod SHIFT ALT, 7, Move silently to workspace 7, movetoworkspacesilent, 7"
        "$mod SHIFT ALT, 8, Move silently to workspace 8, movetoworkspacesilent, 8"
        "$mod SHIFT ALT, 9, Move silently to workspace 9, movetoworkspacesilent, 9"
        "$mod SHIFT ALT, 0, Move silently to workspace 10, movetoworkspacesilent, 10"

        # ── Workspace Navigation ──
        "$mod, TAB, Next workspace, workspace, m+1"
        "$mod SHIFT, TAB, Previous workspace, workspace, m-1"
        "$mod CTRL, TAB, Last workspace, workspace, previous"

        # ── Scratchpad ──
        "$mod, S, Toggle scratchpad, togglespecialworkspace, scratchpad"
        "$mod ALT, S, Move to scratchpad, movetoworkspace, special:scratchpad"

        # ── Multi-Monitor ──
        "$mod SHIFT ALT, left, Move workspace to left monitor, movecurrentworkspacetomonitor, l"
        "$mod SHIFT ALT, right, Move workspace to right monitor, movecurrentworkspacetomonitor, r"

        # ── Window Swap ──
        "$mod SHIFT, left, Swap window left, swapwindow, l"
        "$mod SHIFT, right, Swap window right, swapwindow, r"
        "$mod SHIFT, up, Swap window up, swapwindow, u"
        "$mod SHIFT, down, Swap window down, swapwindow, d"

        # ── Resize ──
        "$mod, minus, Shrink window, splitratio, -0.1"
        "$mod, equal, Grow window, splitratio, +0.1"

        # ── Groups ──
        "$mod, G, Toggle group, togglegroup"
        "$mod ALT, G, Move out of group, moveoutofgroup"
        "$mod ALT, TAB, Next in group, changegroupactive, f"
        "$mod CTRL, left, Previous in group, changegroupactive, b"
        "$mod CTRL, right, Next in group, changegroupactive, f"

        # ── Launcher ──
        "$mod, SPACE, Open launcher, exec, walker"
        "$mod, F1, Show keybindings, exec, ghostty --class=hyprkeys -e ${showKeybinds}"

        # ── Clipboard ──
        "$mod, C, Copy, exec, wtype -M ctrl -k Insert -m ctrl"
        "$mod, V, Paste, exec, wtype -M shift -k Insert -m shift"
        "$mod, X, Cut, exec, wtype -M ctrl -k x -m ctrl"
        "$mod CTRL, V, Clipboard history, exec, cliphist list | walker --dmenu | cliphist decode | wl-copy"

        # ── Notifications ──
        "$mod, comma, Clear notifications, exec, swaync-client -C -sw"
        "$mod SHIFT, comma, Close all notifications, exec, swaync-client --close-all"
        "$mod CTRL, comma, Do not disturb, exec, swaync-client -d -sw"
        "$mod ALT, comma, Toggle notification panel, exec, swaync-client -t -sw"

        # ── Captures ──
        ", Print, Screenshot region, exec, grim -g \"$(slurp)\" - | satty --filename -"
        "SHIFT, Print, Screenshot to clipboard, exec, grim -g \"$(slurp)\" - | wl-copy"
        "$mod, Print, Color picker, exec, hyprpicker -a"

        # ── System ──
        "$mod CTRL, L, Lock screen, exec, hyprlock"
        "$mod SHIFT, SPACE, Toggle waybar, exec, pkill -SIGUSR1 waybar"
        "$mod, BACKSPACE, Toggle opacity, exec, hyprctl keyword decoration:active_opacity $(hyprctl getoption decoration:active_opacity | grep float | awk '{if ($2 == 1.0) print 0.97; else print 1.0}')"
      ];

      # ── Mouse Bindings ──
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      # ── Media Keys (repeatable) ──
      bindeld = [
        ", XF86AudioRaiseVolume, Volume up, exec, swayosd-client --output-volume raise"
        ", XF86AudioLowerVolume, Volume down, exec, swayosd-client --output-volume lower"
        ", XF86MonitorBrightnessUp, Brightness up, exec, swayosd-client --brightness raise"
        ", XF86MonitorBrightnessDown, Brightness down, exec, swayosd-client --brightness lower"
        "ALT, XF86AudioRaiseVolume, Volume up (fine), exec, swayosd-client --output-volume +1"
        "ALT, XF86AudioLowerVolume, Volume down (fine), exec, swayosd-client --output-volume -1"
        "ALT, XF86MonitorBrightnessUp, Brightness up (fine), exec, swayosd-client --brightness +1"
        "ALT, XF86MonitorBrightnessDown, Brightness down (fine), exec, swayosd-client --brightness -1"
      ];

      # ── Media Keys (lock-screen) ──
      bindld = [
        ", XF86AudioMute, Mute audio, exec, swayosd-client --output-volume mute-toggle"
        ", XF86AudioMicMute, Mute mic, exec, swayosd-client --input-volume mute-toggle"
        ", XF86AudioPlay, Play/pause, exec, playerctl play-pause"
        ", XF86AudioNext, Next track, exec, playerctl next"
        ", XF86AudioPrev, Previous track, exec, playerctl previous"
        "$mod, XF86AudioMute, Switch audio output, exec, swayosd-client --output-volume toggle-default"
      ];
    };
  };
}
