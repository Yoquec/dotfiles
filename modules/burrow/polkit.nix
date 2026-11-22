# https://wiki.nixos.org/wiki/Polkit
{ ... }:
{
  burrow.polkit.homeManager =
    { pkgs, ... }:
    {
      systemd.user.services.polkit-gnome-authentication-agent-1 = {
        Unit = {
          Description = "polkit-gnome-authentication-agent-1";
          PartOf = [ "graphical-session.target" ];
          After = [ "graphical-session.target" ];
        };

        Service = {
          ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
          Restart = "on-failure";
        };

        Install.WantedBy = [ "graphical-session.target" ];
      };
    };
}
