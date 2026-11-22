# https://wiki.nixos.org/wiki/GNOME/Keyring
{ ... }:
{
  burrow.keyring.nixos = {
    services.gnome.gnome-keyring.enable = true;
    programs.seahorse.enable = true;
    security.pam.services.login.enableGnomeKeyring = true;
  };
}
