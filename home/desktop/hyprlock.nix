{ config, pkgs, ... }:

{
  programs.hyprlock = {
    enable = true;

    settings = {
      general = {
        hide_cursor = true;
        grace = 5;
      };

      background = [
        {
          monitor = "";
          blur_passes = 4;
          blur_size = 6;
          noise = 0.0117;
          contrast = 0.8916;
          brightness = 0.8172;
          vibrancy = 0.1696;
          vibrancy_darkness = 0.0;
        }
      ];

      label = [
        {
          # Clock
          monitor = "";
          text = "cmd[update:1000] echo \"$(date +\"%I:%M %p\")\"";
          color = "rgba(51, 204, 255, 1.0)";
          font_size = 54;
          font_family = "CaskaydiaMono Nerd Font";
          position = "0, 80";
          halign = "center";
          valign = "center";
        }
        {
          # Date
          monitor = "";
          text = "cmd[update:3600000] echo \"$(date +\"%A, %d %B\")\"";
          color = "rgba(169, 177, 214, 0.8)";
          font_size = 18;
          font_family = "CaskaydiaMono Nerd Font";
          position = "0, 20";
          halign = "center";
          valign = "center";
        }
      ];

      input-field = [
        {
          monitor = "";
          size = "300, 50";
          outline_thickness = 2;
          dots_size = 0.2;
          dots_spacing = 0.3;
          dots_center = true;
          outer_color = "rgba(51, 204, 255, 0.5)";
          inner_color = "rgba(26, 27, 38, 0.8)";
          font_color = "rgba(169, 177, 214, 1.0)";
          fade_on_empty = false;
          placeholder_text = "<i>Password...</i>";
          hide_input = false;
          rounding = 10;
          position = "0, -60";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}
