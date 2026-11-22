# https://wiki.nixos.org/wiki/Bluetooth
{ ... }:
{
  burrow.bluetooth = {
    nixos = {
      hardware.bluetooth = {
        enable = true;
        powerOnBoot = true;
      };

      services.blueman.enable = true;
    };

    homeManager = {
      services.blueman-applet = {
        enable = true;
        systemdTargets = [ "graphical-session.target" ];
      };

      # bridges bluetooth AVRCP buttons (play/pause/next on headsets) to
      # MPRIS, so they reach whichever player is running.
      services.mpris-proxy.enable = true;
    };
  };
}
