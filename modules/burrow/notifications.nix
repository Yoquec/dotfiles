# https://github.com/emersion/mako
{ yoq, ... }:
{
  burrow.notifications = {
    includes = [ yoq.theme ];

    homeManager =
      { pkgs, ... }:
      {
        services.mako.enable = true;
        home.packages = [ pkgs.libnotify ];
      };
  };
}
