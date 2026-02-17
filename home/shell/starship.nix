{ config, pkgs, ... }:

{
  programs.starship = {
    enable = true;
    enableNushellIntegration = true;
    enableBashIntegration = true;

    settings = {
      # Prompt structure
      format = "$directory$git_branch$git_status$nix_shell$container$cmd_duration$line_break$character";
      right_format = "$time";
      add_newline = true;

      character = {
        success_symbol = "[❯](bold cyan)";
        error_symbol = "[❯](bold red)";
        vimcmd_symbol = "[❮](bold green)";
      };

      directory = {
        truncation_length = 3;
        truncate_to_repo = true;
        style = "bold blue";
        read_only = " 🔒";
      };

      git_branch = {
        format = "[$symbol$branch]($style) ";
        symbol = " ";
        style = "bold purple";
      };

      git_status = {
        format = "([$all_status$ahead_behind]($style) )";
        style = "bold red";
        conflicted = "⚡";
        ahead = "⇡\${count}";
        behind = "⇣\${count}";
        diverged = "⇕⇡\${ahead_count}⇣\${behind_count}";
        untracked = "?\${count}";
        stashed = "📦";
        modified = "!\${count}";
        staged = "+\${count}";
        deleted = "✘\${count}";
      };

      nix_shell = {
        format = "[$symbol$state]($style) ";
        symbol = "❄️ ";
        style = "bold cyan";
      };

      container = {
        format = "[$symbol$name]($style) ";
        symbol = "📦 ";
        style = "bold dimmed blue";
      };

      cmd_duration = {
        min_time = 2000;
        format = "[$duration]($style) ";
        style = "bold yellow";
        show_milliseconds = false;
      };

      time = {
        disabled = false;
        format = "[$time]($style)";
        style = "dimmed white";
        time_format = "%H:%M";
      };
    };
  };
}
