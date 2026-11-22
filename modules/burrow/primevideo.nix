# https://www.primevideo.com
{
  inputs,
  den,
  yoq,
  burrow,
  ...
}:
{
  burrow.primevideo = {
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
              name = "primevideo";
              browser = pkgs.google-chrome;
              url = "https://www.primevideo.com";
              description = "Prime Video";
            }
          )
        ];
      };
  };
}
