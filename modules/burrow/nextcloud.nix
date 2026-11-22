# https://github.com/nextcloud/desktop
{
  inputs,
  yoq,
  burrow,
  ...
}:
{
  burrow.nextcloud = {
    includes = [
      yoq.lib.jail
      burrow.keyring
      burrow.graphics
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
        services.nextcloud-client = {
          enable = true;
          startInBackground = true;
        };

        programs.zk.settings.notebook.dir = "${config.home.homeDirectory}/Nextcloud/Notes";

        home.packages = [
          (inputs.self.lib.mkContainerizedWebapp
            {
              inherit pkgs lib jail;
              inherit (config.home) homeDirectory;
            }
            {
              name = "nextcloud-web";
              browser = pkgs.ungoogled-chromium;
              url = "https://cloud.yoquec.com";
              description = "Nextcloud";
              extraCombinators = with jail.combinators; [
                yubikey
                (try-readwrite "${config.home.homeDirectory}/Downloads")
              ];
            }
          )
        ];
      };
  };
}
