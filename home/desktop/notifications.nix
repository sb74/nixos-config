{ config, pkgs, ... }:

{
  # SwayNotificationCenter — notifications with history panel
  services.swaync = {
    enable = true;

    settings = {
      positionX = "right";
      positionY = "top";
      layer = "overlay";
      control-center-layer = "top";
      layer-shell = true;
      cssPriority = "application";
      control-center-margin-top = 8;
      control-center-margin-bottom = 8;
      control-center-margin-right = 8;
      control-center-width = 400;
      notification-icon-size = 48;
      notification-window-width = 400;
      timeout = 5;
      timeout-low = 3;
      timeout-critical = 0;
      fit-to-screen = true;
      keyboard-shortcuts = true;
      image-visibility = "when-available";
      transition-time = 200;
      hide-on-clear = true;
      hide-on-action = true;
      script-fail-notify = true;

      widgets = [
        "inhibitors"
        "title"
        "dnd"
        "notifications"
      ];

      widget-config = {
        inhibitors = {
          text = "Inhibitors";
          button-text = "Clear All";
          clear-all-button = true;
        };
        title = {
          text = "Notifications";
          clear-all-button = true;
          button-text = "Clear All";
        };
        dnd = {
          text = "Do Not Disturb";
        };
      };
    };

    style = ''
      * {
        font-family: 'CaskaydiaMono Nerd Font';
        font-size: 12px;
      }

      .notification-row {
        outline: none;
      }

      .notification {
        border-radius: 10px;
        margin: 4px 8px;
        padding: 0;
        border: 2px solid #7aa2f7;
        background: rgba(26, 27, 38, 0.95);
        color: #a9b1d6;
      }

      .notification-content {
        padding: 8px 12px;
      }

      .close-button {
        background: #f7768e;
        color: #1a1b26;
        border-radius: 50%;
        min-width: 20px;
        min-height: 20px;
        margin: 4px;
      }

      .control-center {
        background: rgba(26, 27, 38, 0.95);
        border: 2px solid #7aa2f7;
        border-radius: 10px;
        color: #a9b1d6;
        padding: 8px;
      }

      .control-center .notification {
        border: 1px solid #44445588;
      }

      .widget-title {
        color: #7aa2f7;
        font-weight: bold;
        font-size: 14px;
        margin: 4px 8px;
      }

      .widget-title > button {
        background: #f7768e;
        color: #1a1b26;
        border-radius: 6px;
        padding: 2px 8px;
      }

      .widget-dnd > switch {
        border-radius: 6px;
        background: #44445588;
      }

      .widget-dnd > switch:checked {
        background: #e0af68;
      }
    '';
  };
}
