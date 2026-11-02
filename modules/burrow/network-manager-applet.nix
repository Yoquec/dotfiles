# https://wiki.gnome.org/Projects/NetworkManagerApplet
{ ... }:
{
  burrow.network-manager-applet.homeManager =
    { pkgs, lib, ... }:
    {
      home.packages = [ pkgs.networkmanagerapplet ];

      systemd.user.services.nm-applet = {
        Unit = {
          Description = "Network Manager tray applet";
          PartOf = [ "graphical-session.target" ];
          After = [ "graphical-session.target" ];
        };

        Service = {
          ExecStart = "${lib.getExe' pkgs.networkmanagerapplet "nm-applet"} --indicator";
          Restart = "on-failure";
        };

        Install.WantedBy = [ "graphical-session.target" ];
      };
    };
}
