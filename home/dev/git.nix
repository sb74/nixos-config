{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "sb74";
    userEmail = "snbr74@gmail.com";

    lfs.enable = true;

    signing = {
      key = "~/.ssh/id_ed25519.pub";
      signByDefault = true;
    };

    delta = {
      enable = true;
      options = {
        navigate = true;
        side-by-side = true;
        line-numbers = true;
        syntax-theme = "TwoDark";
      };
    };

    extraConfig = {
      gpg.format = "ssh";
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      pull.rebase = true;
      merge.conflictstyle = "zdiff3";
      rerere.enabled = true;
      diff.colorMoved = "default";
      core.autocrlf = "input";
      url."git@github.com:".insteadOf = "gh:";
    };

    aliases = {
      s = "status -sb";
      l = "log --oneline --graph --decorate -20";
      la = "log --oneline --graph --decorate --all -30";
      co = "checkout";
      cb = "checkout -b";
      cm = "commit -m";
      ca = "commit --amend --no-edit";
      d = "diff";
      ds = "diff --staged";
      p = "push";
      pf = "push --force-with-lease";
      pl = "pull";
      unstage = "reset HEAD --";
      last = "log -1 HEAD --stat";
    };
  };

  # Lazygit — TUI for git
  programs.lazygit = {
    enable = true;
    settings = {
      gui = {
        showIcons = true;
        nerdFontsVersion = "3";
        theme = {
          activeBorderColor = [ "#7aa2f7" "bold" ];
          inactiveBorderColor = [ "#44445588" ];
          selectedLineBgColor = [ "#283457" ];
        };
      };
      git = {
        paging = {
          colorArg = "always";
          pager = "delta --dark --paging=never";
        };
      };
    };
  };
}
