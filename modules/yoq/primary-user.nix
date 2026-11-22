# Wraps den.batteries.primary-user and, additionally, delivers this user's
# name to the host as config.yoq.primaryUser.
{ den, burrow, ... }:
{
  yoq.primary-user =
    { user, host, ... }:
    {
      name = "yoq-primary-user(${user.userName}@${host.name})";

      includes = [
        den.batteries.primary-user
        burrow.primary-user
      ];

      provides.to-hosts.nixos.config.yoq.primaryUser = user.userName;
    };
}
