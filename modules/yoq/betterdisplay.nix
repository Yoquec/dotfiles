# https://github.com/waydabber/BetterDisplay
{ den, ... }:
{
  yoq.betterdisplay = {
    includes = [ (den.batteries.unfree [ "betterdisplay" ]) ];

    # home-manager's targets.darwin.copyApps (the default since
    # home.stateVersion >= "25.11", which ours is) already rsync-copies
    # .app bundles from home.packages into ~/Applications/Home Manager Apps
    # so Spotlight/Launchpad see them -- no extra module needed for a GUI app.
    homeManager =
      { pkgs, ... }:
      {
        home.packages = [ pkgs.betterdisplay ];
      };
  };
}
