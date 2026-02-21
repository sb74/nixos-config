{ config, pkgs, ... }:

{
  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 32;
        margin-top = 4;
        margin-left = 6;
        margin-right = 6;

        modules-left = [
          "hyprland/workspaces"
          "hyprland/window"
        ];

        modules-center = [
          "clock"
        ];

        modules-right = [
          "mpris"
          "tray"
          "bluetooth"
          "network"
          "pulseaudio"
          "disk"
          "memory"
          "cpu"
          "idle_inhibitor"
        ];

        # ── Module Configs ──

        "hyprland/workspaces" = {
          format = "{id}";
          on-click = "activate";
          persistent-workspaces = {
            "*" = [ 1 2 3 4 5 ];
          };
        };

        "hyprland/window" = {
          max-length = 40;
        };

        clock = {
          format = "{:%a %H:%M}";
          format-alt = "{:%d %B W%V %Y}";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
        };

        mpris = {
          format = "{player_icon} {dynamic}";
          format-paused = "{player_icon} <i>{dynamic}</i>";
          dynamic-len = 30;
          player-icons = {
            default = "▶";
            spotify = "";
            firefox = "";
            chromium = "";
          };
          on-click = "playerctl play-pause";
          on-scroll-up = "playerctl next";
          on-scroll-down = "playerctl previous";
        };

        tray = {
          icon-size = 16;
          spacing = 8;
        };

        bluetooth = {
          format = "󰂯";
          format-disabled = "󰂲";
          format-connected = "󰂱 {num_connections}";
          tooltip-format = "{controller_alias}\n{num_connections} connected";
          on-click = "bluetui";
        };

        network = {
          format-wifi = "{icon}";
          format-ethernet = "󰈀";
          format-disconnected = "󰤮";
          format-icons = [ "󰤟" "󰤢" "󰤥" "󰤨" ];
          tooltip-format = "{essid} ({signalStrength}%)\n{ipaddr}/{cidr}";
          on-click = "nm-connection-editor";
        };

        pulseaudio = {
          format = "{icon} {volume}%";
          format-muted = "󰝟";
          format-icons = {
            default = [ "󰕿" "󰖀" "󰕾" ];
          };
          on-click = "pwvucontrol";
          on-scroll-up = "swayosd-client --output-volume raise";
          on-scroll-down = "swayosd-client --output-volume lower";
        };

        disk = {
          format = "󰋊 {percentage_used}%";
          path = "/";
        };

        memory = {
          format = "󰍛 {percentage}%";
        };

        cpu = {
          format = "󰻠 {usage}%";
        };

        idle_inhibitor = {
          format = "{icon}";
          format-icons = {
            activated = "󰅶";
            deactivated = "󰾪";
          };
        };
      };
    };

    style =
      let
        c = config.lib.stylix.colors;
      in
      ''
        * {
          font-family: 'CaskaydiaMono Nerd Font';
          font-size: 12px;
          min-height: 0;
        }

        window#waybar {
          background-color: rgba(${c.base00-rgb-r}, ${c.base00-rgb-g}, ${c.base00-rgb-b}, 0.9);
          border-radius: 10px;
          color: #${c.base05};
        }

        #workspaces button {
          padding: 0 6px;
          color: #${c.base04};
          border-bottom: 2px solid transparent;
        }

        #workspaces button.active {
          color: #${c.base0D};
          border-bottom: 2px solid #${c.base0D};
        }

        #workspaces button:hover {
          background: rgba(${c.base0D-rgb-r}, ${c.base0D-rgb-g}, ${c.base0D-rgb-b}, 0.2);
        }

        #window {
          margin-left: 12px;
          opacity: 0.6;
          font-style: italic;
        }

        #clock {
          font-weight: bold;
        }

        #idle_inhibitor.activated {
          color: #${c.base0A};
        }

        #mpris.paused {
          opacity: 0.4;
        }

        #tray,
        #bluetooth,
        #network,
        #pulseaudio,
        #disk,
        #memory,
        #cpu,
        #idle_inhibitor,
        #mpris {
          padding: 0 8px;
        }
      '';
  };
}
