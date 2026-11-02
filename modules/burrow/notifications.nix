# https://github.com/emersion/mako
{ yoq, ... }:
{
  burrow.notifications = {
    includes = [ yoq.theme ];

    homeManager = {
      services.mako.enable = true;
    };
  };
}
