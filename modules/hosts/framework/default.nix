{ yoq, burrow, ... }:
let
  wallpaper = ../../../assets/wallpapers/charcoal_creation_of_adam.png;
in
{
  den.aspects.framework = {
    includes = [
      yoq.nix
      burrow.bootloader
      burrow.desktop
      yoq.browser
      yoq.ghostty
      burrow.fprint
      burrow.office
      burrow.multimedia
      burrow.fwupd
    ];

    provides.to-users.homeManager =
      { pkgs, ... }:
      let
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
      { pkgs, ... }:
      {
        environment.systemPackages = [ pkgs.hello ];

        # VM's store is a read-only mount of the host's, so home-manager's
        # default activation-time profile build fails there; bake user
        # packages into the system closure instead, for the VM only.
        virtualisation.vmVariant.home-manager.useUserPackages = true;
      };
  };
}
