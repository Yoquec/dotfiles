# Declares the shared yoq.primaryUser NixOS option. Included by both the
# producer, set by yoq.primary-user
# Consumers (e.g burrow.sway.autologin) can read the option to get
# information about the primary user.
{ ... }:
{
  burrow.primary-user.nixos =
    { lib, ... }:
    {
      options.yoq.primaryUser = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
        description = "Username this host treats as primary, for aspects that need exactly one winner.";
      };
    };
}
