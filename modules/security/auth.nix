{ config, pkgs, ... }:

{
  # PAM hardening — delay between failed auth attempts
  security.pam.services.login.failDelay = {
    enable = true;
    delay = 4000000;  # 4 seconds between failed attempts
  };

  security.pam.services.su.requireWheel = true;

  # hyprlock — must exist or every unlock attempt fails
  security.pam.services.hyprlock = {};

  # gnome-keyring — unlock on login so apps (Spotify, etc.) don't prompt repeatedly
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.greetd.enableGnomeKeyring = true;

  # 1Password — GUI + SSH agent + browser extension + polkit
  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ "sb74" ];
  };

  # Process limits
  security.pam.loginLimits = [
    { domain = "*"; type = "soft"; item = "nofile"; value = "8192"; }
    { domain = "*"; type = "hard"; item = "nofile"; value = "65536"; }
  ];

  # Kernel hardening — sysctl tweaks
  boot.kernel.sysctl = {
    # Hide kernel pointers from non-root
    "kernel.kptr_restrict" = 2;

    # Restrict dmesg access to root
    "kernel.dmesg_restrict" = 1;

    # Restrict ptrace to direct parent only
    "kernel.yama.ptrace_scope" = 1;

    # Disable unprivileged BPF
    "kernel.unprivileged_bpf_disabled" = 1;

    # Harden BPF JIT compiler
    "net.core.bpf_jit_harden" = 2;

    # Ignore ICMP redirects (MITM protection)
    "net.ipv4.conf.all.accept_redirects" = 0;
    "net.ipv4.conf.default.accept_redirects" = 0;
    "net.ipv6.conf.all.accept_redirects" = 0;
    "net.ipv6.conf.default.accept_redirects" = 0;

    # Don't send ICMP redirects
    "net.ipv4.conf.all.send_redirects" = 0;
    "net.ipv4.conf.default.send_redirects" = 0;

    # Ignore source-routed packets
    "net.ipv4.conf.all.accept_source_route" = 0;
    "net.ipv4.conf.default.accept_source_route" = 0;
    "net.ipv6.conf.all.accept_source_route" = 0;
    "net.ipv6.conf.default.accept_source_route" = 0;

    # Enable TCP SYN cookies (SYN flood protection)
    "net.ipv4.tcp_syncookies" = 1;

    # Log martian packets
    "net.ipv4.conf.all.log_martians" = 1;
    "net.ipv4.conf.default.log_martians" = 1;
  };
}
