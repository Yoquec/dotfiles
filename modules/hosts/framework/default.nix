{ yoq, burrow, ... }:
let
  wallpapers = {
    dark = ../../../assets/wallpapers/charcoal_creation_of_adam.png;
    light = ../../../assets/wallpapers/stone_creation_of_adam_dark.png;
  };
in
{
  den.aspects.framework = {
    includes = [
      yoq.nix
      burrow.bootloader
      burrow.desktop
      yoq.browser
      burrow.fprint
      burrow.office
      burrow.multimedia
    ];

    provides.to-users.homeManager =
      { pkgs, config, ... }:
      let
        wallpaper = wallpapers.${config.yoq.theme.polarity};

        dimWallpaper =
          pkgs.runCommand "wallpaper-dim.png"
            {
              nativeBuildInputs = [ pkgs.imagemagick ];
            }
            ''
              magick ${wallpaper} -blur 0x2 -modulate 15 "$out"
            '';
      in
      {
        stylix = {
          image = wallpaper;
          targets.swaylock.image.override = "${dimWallpaper}";
        };
      };

    nixos =
      { ... }:
      {
        time.timeZone = "Europe/Madrid";

        virtualisation.vmVariant = {
          # VM's store is a read-only mount of the host's, so home-manager's
          # default activation-time profile build fails there; bake user
          # packages into the system closure instead, for the VM only.
          home-manager.useUserPackages = true;
        };
      };
  };
}
