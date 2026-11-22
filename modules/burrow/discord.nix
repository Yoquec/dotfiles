# https://discord.com
{ inputs, yoq, ... }:
{
  burrow.discord = {
    includes = [ yoq.lib.jail ];

    homeManager =
      {
        jail,
        pkgs,
        lib,
        config,
        ...
      }:
      {
        home.packages = [
          (inputs.self.lib.mkContainerizedWebapp
            {
              inherit pkgs lib jail;
              inherit (config.home) homeDirectory;
            }
            {
              name = "discord";
              browser = pkgs.ungoogled-chromium;
              url = "https://discord.com";
              description = "Discord";
              extraCombinators = with jail.combinators; [
                camera
                notifications
                (try-readwrite "${config.home.homeDirectory}/Downloads")
              ];
            }
          )
        ];
      };
  };
}
