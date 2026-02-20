let
  keys = import ../keys.nix;
  inherit (keys) sb74 testbed pc laptop;
in
{
  "user-password-testbed.age".publicKeys = [ sb74 testbed ];
  "user-password-pc.age".publicKeys      = [ sb74 pc ];
  "user-password-laptop.age".publicKeys  = [ sb74 laptop ];
}
