# https://wiki.nixos.org/wiki/Zathura
{ ... }:
{
  burrow.zathura.homeManager = {
    programs.zathura.enable = true;
    xdg.mimeApps.defaultApplications."application/pdf" = "org.pwmt.zathura.desktop";
  };
}
