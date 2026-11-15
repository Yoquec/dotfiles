# https://wiki.nixos.org/wiki/Greetd
#
# A host with more than one user would fan this out once per user, all
# writing to the same services.greetd.settings path. Gate on
# config.yoq.primaryUser (set by yoq.primary-user) so exactly one wins.
{ burrow, ... }:
{
  burrow.sway.autologin = {
    includes = [ burrow.primary-user ];

    nixos =
      {
        user,
        pkgs,
        lib,
        config,
        ...
      }:
      lib.mkIf (config.yoq.primaryUser == user.userName) {
        programs.sway.enable = true;

        services.greetd = {
          enable = true;
          settings = rec {
            initial_session = {
              command = lib.getExe pkgs.sway;
              user = user.userName;
            };
            default_session = initial_session;
          };
        };
      };
  };

  burrow.sway.includes = [ burrow.sway.autologin ];
}
