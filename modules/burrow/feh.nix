# https://wiki.nixos.org/wiki/Feh
{ ... }:
{
  burrow.feh.homeManager = {
    programs.feh.enable = true;
    xdg.mimeApps.defaultApplications = {
      "image/png" = "feh.desktop";
      "image/jpeg" = "feh.desktop";
      "image/gif" = "feh.desktop";
    };
  };
}
