# https://wiki.nixos.org/wiki/Fingerprint_scanner
{ ... }:
{
  burrow.fprint.nixos = {
    services.fprintd.enable = true;

    # fingerprint stays a parallel auth method, not a password replacement:
    # these PAM stacks still fall back to a password if no finger matches.
    security.pam.services.sudo.fprintAuth = true;
    security.pam.services.login.fprintAuth = true;
    security.pam.services.swaylock.fprintAuth = true;
  };
}
