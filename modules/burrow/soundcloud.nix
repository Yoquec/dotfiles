# https://soundcloud.com
{
  inputs,
  den,
  yoq,
  burrow,
  ...
}:
{
  burrow.soundcloud = {
    includes = [
      yoq.lib.jail
      burrow.graphics
      (den.batteries.unfree [ "google-chrome" ])
    ];

    homeManager =
      {
        jail,
        pkgs,
        lib,
        config,
        ...
      }:
      {
        # uses proprietary google chrome for DRM
        home.packages = [
          (inputs.self.lib.mkContainerizedWebapp
            {
              inherit pkgs lib jail;
              inherit (config.home) homeDirectory;
            }
            {
              name = "soundcloud";
              browser = pkgs.google-chrome;
              url = "https://soundcloud.com";
              description = "SoundCloud";
              extraCombinators = with jail.combinators; [
                notifications
                # MPRIS control
                (dbus { own = [ "org.mpris.MediaPlayer2.*" ]; })
              ];
            }
          )
        ];
      };
  };
}
