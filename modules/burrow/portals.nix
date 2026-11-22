# https://wiki.nixos.org/wiki/Sway#Screen_sharing_(and_other_desktop_portals)
{ ... }:
{
  burrow.portals.nixos =
    { pkgs, ... }:
    {
      xdg.portal = {
        enable = true;
        extraPortals = [
          pkgs.xdg-desktop-portal-wlr
          pkgs.xdg-desktop-portal-gtk
        ];
      };
    };
}
