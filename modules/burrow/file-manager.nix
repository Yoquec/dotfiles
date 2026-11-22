# https://wiki.nixos.org/wiki/Nautilus
# https://wiki.nixos.org/wiki/MTP#gvfs
{ yoq, ... }:
{
  burrow.file-manager = {
    includes = [ yoq.theme ];

    # MTP (e.g. mounting an Android phone) support for GIO/GTK file managers.
    nixos.services.gvfs.enable = true;

    homeManager = { pkgs, ... }: { home.packages = [ pkgs.nautilus ]; };
  };
}
